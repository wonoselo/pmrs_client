<template>
	<!-- begin error -->
	<div class="error">
		<div class="error-code m-b-10">404</div>
		<div class="error-content">
			<div class="error-message">We couldn't find it...</div>
			<div class="error-desc m-b-30">
				The page you're looking for doesn't exist. <br />
				Perhaps, there pages will help find what you're looking for.
			</div>
			<div>
				<router-link to="/dashboard" class="btn btn-success p-l-20 p-r-20">Back to Dashboard</router-link>
			</div>
		</div>
	</div>
	<!-- end error -->
</template>

<script>
import PageOptions from '../config/PageOptions.vue'

export default {
	created() {
		PageOptions.pageEmpty = false;
	},
	beforeRouteLeave (to, from, next) {
		PageOptions.pageEmpty = false;
		next();
	}
}
</script>
<style scoped>
.error {
	height:100% !important;
}
</style>