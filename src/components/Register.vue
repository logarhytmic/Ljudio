<template>
  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title">Login</span>
    <form @submit.prevent="">
      <div class="modal__content">
        <label ref="modalLabel" id="modal-p"></label>
        <input
          v-model="_data.first_name"
          type="text"
          id="input-forename"
          name="input-forename"
          alt="input-forename"
          placeholder="Forename..."
        />
        <input
          v-model="_data.last_name"
          type="text"
          id="input-surname"
          name="input-surname"
          alt="input-surname"
          placeholder="Surname..."
        />
        <input
          v-model="_data.email"
          type="text"
          id="input-email"
          name="input-email"
          alt="input-email"
          placeholder="Email..."
        />
        <input
          v-model="_data.password"
          type="password"
          id="input-secret"
          name="input-secret"
          alt="input-secret"
          placeholder="Password..."
        />
      </div>
      <div class="modal__action">
        <button class="vfm-btn" @click="Register()">confirm</button>
        <button class="vfm-btn" @click="CloseModal()">cancel</button>
      </div>
    </form>
  </vue-final-modal>
  <button class="vfm-btn" @click="showModal = true">Register</button>
</template>

<script>
export default {
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
  border: 1px solid #e2e8f0;
  border-radius: 0.25rem;
  background: #fff;
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
  padding: 1rem 0 0;
}

.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}
</style>
