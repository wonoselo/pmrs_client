<template>
  <div></div>
</template>

<script>
export default {
  async mounted() {
    this.$store.dispatch('auth/logout');
    this.$router.push({ path: '/login' });
  },
};
</script>
