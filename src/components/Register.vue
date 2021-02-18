<template>
  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title"></span>
    <form @submit.prevent="">
      <div class="modal__content">
        <label ref="modalLabel" id="modal-p"></label>
        <div class="container-input">
          <div class="user-box">
            <input
              v-model="_data.first_name"
              type="text"
              name="input-firstname"
              alt="input-firstname"
              required
            />
            <label>Forename</label>
          </div>
          <div class="user-box">
            <input
              v-model="_data.last_name"
              type="text"
              name="input-surname"
              alt="input-surname"
              required
            />
            <label>Surname</label>
          </div>
          <div class="user-box">
            <input
              v-model="_data.email"
              type="email"
              name="input-email"
              alt="input-email"
              required
            />
            <label>Email</label>
          </div>
          <div class="user-box">
            <input
              v-model="_data.password"
              type="password"
              name="input-secret"
              alt="input-secret"
              required
            />
            <label>Password</label>
          </div>
        </div>
        <div class="modal__action">
          <div class="button_base b12_3d_glitch">
            <div></div>
            <div @click.prevent="Register()">Sign up</div>
          </div>
          <div class="button_base b12_3d_glitch">
            <div></div>
            <div @click.prevent="CloseModal()">Cancel</div>
          </div>
        </div>
      </div>
    </form>
  </vue-final-modal>
  <div class="button_base b12_3d_glitch">
    <div></div>
    <div @click.prevent="showModal = true">Sign up</div>
  </div>
</template>

<script>
export default {
  name: "RegisterModal",
  data() {
    return {
      showModal: false,
      _data: {
        first_name: "",
        last_name: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
    CloseModal() {
      this.showModal = false;
      this._data.first_name = "";
      this._data.last_name = "";
      this._data.email = "";
      this._data.password = "";
    },
    Register() {
      if (
        this._data.first_name.trim().length > 0 &&
        this._data.last_name.trim().length > 0 &&
        this._data.email.trim().length > 0 &&
        this._data.password.trim().length > 0
      ) {
        fetch("/api/users", {
          method: "POST",
          body: JSON.stringify(this._data),
          cache: "no-cache",
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((r) => r.json())
          .then((d) => {
            if (d.affectedRows === 1) {
              console.log("Success:", d);
              this.showModal = false;
              this._data.first_name = "";
              this._data.last_name = "";
              this._data.email = "";
              this._data.password = "";
            } else {
              console.log("Unsuccessful:", d);
              this.$refs.modalLabel.innerText = "Something went wrong! :(";
              this._data.password = "";
            }
          })
          .catch((e) => {
            console.error("Error:", e);
          });
      }
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css?family=Roboto+Condensed");

.container-input {
  margin-top: 10px;
}

label {
  color: white;
}

/* ==== Validation CSS ==== */

input:required {
  box-shadow:none;
}

/* ==== Modal CSS ==== */

:deep(.modal-container) {
  display: flex;
  justify-content: center;
  align-items: center;
}

:deep(.modal-content) {
  position: relative;
  display: flex;
  flex-direction: column;
  max-height: 90%;
  margin: 0 1rem;
  padding: 1rem;
  border: 1px solid coral;
  border-radius: 0.25rem;
  background: #231123;
}

.modal__title {
  margin: 0 2rem 0 0;
  font-size: 1.5rem;
  font-weight: 700;
}

.modal__content {
  flex-grow: 1;
  overflow-y: auto;
  color: black;
}

.modal__action {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
  /* padding: 1rem 0 0; */
}

.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}

/* ==== Input CSS ==== */

.user-box {
  position: relative;
}

.user-box input {
  width: 100%;
  padding: 10px 0;
  font-size: 16px;
  color: #fff;
  margin-bottom: 30px;
  border: none;
  border-bottom: 1px solid #fff;
  outline: none;
  background: transparent;
}
.user-box label {
  position: absolute;
  top: 0;
  left: 0;
  padding: 10px 0;
  font-size: 16px;
  color: rgb(143, 143, 143);
  pointer-events: none;
  transition: 0.5s;
}

.user-box input:focus ~ label,
.user-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: coral;
  font-size: 12px;
}

.user-box input:focus,
.user-box input:valid {
  border-bottom: 1px solid coral;
}
</style>
