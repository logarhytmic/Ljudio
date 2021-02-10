<template>
    <header class="header">
        <h1>SPELA SHORELINE</h1>
        <div class="user-auth">
            <UserAuth />
        </div>
    </header>
</template>

<script>
import UserAuth from './UserAuth.vue'

export default {
    name: 'Header',
    components: {
        UserAuth
    },
}
</script>

<style scoped>
    .header {
        display: grid;
        grid-template-columns: 50% 50%;
        grid-template-rows: auto;
        justify-content: space-evenly;
        position: fixed;
        top: 0px;
        width: 100%;
        background: #231123;
        color: #fff;
        text-align: center;
        padding: 20px;
    }

    .header > h1 {
        align-self: center;
    }
</style>