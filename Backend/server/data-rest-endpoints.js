const bcrypt = require("bcrypt");

module.exports = (app, db) => {
    // Authentication routes

    // register user
    app.post('/api/users', async (request, response) => {
        let password = await bcrypt.hash(request.body.password, 10);
        let result = await db.query("INSERT INTO users SET ?", { ...request.body, password })
        response.json(result)
    });

    // authentication: perform login
    app.post('/api/login', async (request, response) => {
        let user = await db.query('SELECT * FROM users WHERE email = ?', [request.body.email])
        user = user[0]

        if (user && user.email && await bcrypt.compare(request.body.password, user.password)) {
            request.session.user = user
            user.loggedIn = true
            response.json({ loggedIn: true })
        } else {
            response.status(401) // unauthorized  https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
            response.json({ message: "no matching user" })
        }
    })

    // authentication: get logged in user
    app.get('/api/login', async (request, response) => {
        let user
        if (request.session.user) {
            user = await db.query(
                'SELECT * FROM users WHERE email = ? AND password = ?',
                [request.session.user.email, request.session.user.password]
            )
            user = user[0]
        }
        if (user && user.email) {
            user.loggedIn = true
            delete (user.password)
            response.json(user)
        } else {
            response.status(401) // unauthorized  https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
            response.json({ message: "not logged in" })
        }
    })

    // logga ut
    app.delete('/api/login', async (request, response) => {
        request.session.destroy(() => {
            response.json({ loggedIn: false })
        })
    })

    app.post('/api/playlists', async (request, response) => {
        let user;
        if (request.session.user) {
            user = await db.query(
                'SELECT * FROM users WHERE email = ? AND password = ?',
                [request.session.user.email, request.session.user.password]
            );
            user = user[0];
            let result = await db.query(
                'INSERT INTO playlist SET ?', [request.title, request.session.user.id]
            );
            response.json(result);
        }
        else {
            response.status(401);
            response.json({ message: "unauthorized" });
        }
    })

    app.get('/api/playlists', async (request, response) => {
        if (request.session.user) {
            user = await db.query(
                'SELECT * FROM users WHERE email = ? AND password = ?',
                [request.session.user.email, request.session.user.password]
            );
            let result = await db.query(
                'SELECT * FROM playlist WHERE userid = ?', request.session.user.id
            );
            response.json(result);
        }
        else {
            response.status(401);
            response.json({ message: "unauthorized" });
        }
    })

    // TODO: optimal way of finding the right playlist?
    // TODO: handle user having no plyalists
    app.post('/api/current', async (request, response) => {
        let user;
        let current_playlist;
        if (request.session.user) {
            user = await db.query(
                'SELECT * FROM users WHERE email = ? AND password = ?',
                [request.session.user.email, request.session.user.password]
            );
            user = user[0];
            let has_playlist = await db.query(
                'SELECT COUNT(*) FROM playlist WHERE userid = ?',
                [request.session.user.id]
            )
            has_playlist = has_playlist[0]
            if (has_playlist > 0) {
                current_playlist = await db.query(
                    'SELECT * FROM playlist WHERE userid = ?',
                    [request.session.user.id]
                );
                current_playlist = current_playlist[0];
                let song_res = await db.query(
                    'INSERT INTO song SET ?',
                    [request.title, request.originator, request.duration]
                );
                let song = song_res[0];
                let pl_song_res = await db.query(
                    'INSERT INTO playlist_song SET ?',
                    [current_playlist.id, song.id]
                );
                response.json(current_playlist);
            } else {
                response.status(404);
                response.json({ message: "user has no playlists" });
            }
        } else {
            response.status(401)
            response.json({ message: "unauthorized" })
        }
    })

    // Example routes

    // public get all table rows
    app.get('/api/examples', async (request, response) => {
        let data = await db.query('SELECT * FROM examples')
        response.json(data)
    })

    // public get one table row
    app.get("/api/examples/:id", async (request, response) => {
        let data = await db.query("SELECT * FROM examples WHERE id = ?", [request.params.id])
        data = data[0] // single row
        response.json(data)
    })

    // public get another table (happens to be a left joined view)
    app.get("/api/examples_with_colors", async (request, response) => {
        let data = await db.query("SELECT * FROM examples_with_colors")
        response.json(data)
    })

    // private create one row
    app.post("/api/examples", async (request, response) => {
        // check if user exists before writing
        if (!request.session.user) {
            response.status(403) // forbidden
            response.json({ error: 'not logged in' })
            return;
        }
        let result = await db.query("INSERT INTO examples SET ?", request.body)
        response.json(result)
    })

    // private update one row
    app.put("/api/examples/:id", async (request, response) => {
        // check if user exists before writing
        if (!request.session.user) {
            response.status(403) // forbidden
            response.json({ error: 'not logged in' })
            return;
        }
        let result = await db.query("UPDATE examples SET ? WHERE id = ?", [request.body, request.params.id])
        response.json(result)
    })

    // private delete one row
    app.delete("/api/examples/:id", async (request, response) => {
        // check if user exists before writing
        if (!request.session.user) {
            response.status(403) // forbidden
            response.json({ error: 'not logged in' })
            return;
        }
        let result = await db.query("DELETE FROM examples WHERE id = ?", request.params.id)
        response.json(result)
    })

    // yt api 404 for any remaining requests on all methods
    app.all('/api/*', async (req, res) => {
        res.status(404)
        res.end()
      })
}
