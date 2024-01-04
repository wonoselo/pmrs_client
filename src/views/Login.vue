<template>
  <div class="bg">
	<DxPopup
	:width="430"
	:height="550"
	:show-title="false"
	:visible="isPopupVisible"
	:close-on-outside-click="false"
	>
	<template #content>
		<div>
			<div class="card header-container"><center> <h3><img src="favicon.png" alt="homepage" style="height:50px;" class="light-logo"> Login to PMRS</h3></center><p style="margin: -20px 80px 0px 200px;">V.2.2.5</p></div>
			
				<div class="card card-container">
				<img
					id="profile-img"
					src="avatar.png"
					class="profile-img-card"
				/>
				<form name="form" @submit.prevent="handleLogin">
					<div class="form-group">
						<label for="username">Username</label>
						<input
							v-model="user.username"
							v-validate="'required'"
							type="text"
							placeholder="Enter Username"
							class="form-control"
							name="username"
						/>
						<div
							v-if="errors.has('username')"
							class="alert alert-danger"
							role="alert"
						>Username is required!</div>
					</div>
					<div class="form-group">
						<label for="password">Password</label>
						<div class="input-group mb-3">
							<input 
							v-model="user.password" 
							v-validate="'required'"
							:type="type" 
							name="password"
							class="form-control" 
							placeholder="Enter Passsword" 
							aria-label="Enter Passsword" />
							<div class="input-group-append">
							<button class="btn btn-outline-secondary" type="button" @click="showPassword"><span class="btn-show-pass"><i :class="iconClass"></i></span></button>
							</div>
						</div>
						<div
							v-if="errors.has('password')"
							class="alert alert-danger"
							role="alert"
						>Password is required!</div>
					</div>
					<div class="form-group">
						<button class="btn btn-primary btn-block" :disabled="loading">
							<span v-show="loading" class="spinner-border spinner-border-sm"></span>
							<span> Login</span>
						</button>
					</div>
					<div class="form-group">
					Don't have an account? <a href="#"  @click="handleRegister"> Register here </a>
					<div v-if="message" class="alert alert-danger" role="alert">{{message}}</div>
					</div>
				</form>
			</div>
			<div class="card header-container"><center>&copy; 2024 By FNH Planning</center></div>
		</div>
	</template>
	</DxPopup>
  </div>
</template>

<script>
import User from '../models/user';
import Swal from 'sweetalert2';
import CrudService from '../services/crud.service';
import { DxPopup } from 'devextreme-vue/popup';
export default {
	name: 'Login',
	components: {
		DxPopup
	},
	data() {
		return {
			user: new User('', ''),
			loading: false,
			message: '',
			isPopupVisible: true,
			type:'password',
			iconClass : 'fa fa-eye'
		};
	},
	methods: {
		showPassword() {
			if(this.type === 'password') {
				this.type = 'text'
				this.iconClass = 'fa fa-eye-slash'
			} else {
				this.type = 'password'
				this.iconClass = 'fa fa-eye'
			}
		},
		handleLogin() {
			this.loading = true;
			this.$validator.validateAll().then(isValid => {
				if (!isValid) {
					this.loading = false;
					return;
				}

				if (this.user.username && this.user.password) {
					
					this.$store.dispatch('auth/login', this.user).then(
					() => {
						this.$router.push(this.$route.query.redirect || "/dashboard");
					},
					error => {
						this.isPopupVisible= false
						Swal.fire({
							icon: 'error',
							title: 'Oops...',
							text: "Login failed : "+error.response.data.message
						}).then(() => {
							this.isPopupVisible = true;
						})
						this.loading = false;
						//this.message = "Login failed : "+error.response.data.message;
					}
					).catch(
						error =>{
							console.log('Show error notification!')
							return Promise.reject(error)
						}
					);
				}
			});
		},
		handleRegister(){
			CrudService.getAll('roles').then(function (role) {
				var regionObject = {
					"HO": [],
					"FNH": ["NORTH 1","NORTH 2","NORTH 3","SOUTH 1","SOUTH 2","ACRA PLANTATION","GLOBAL PLANTATION"]	
				}
				var roleSel = document.getElementById("roleSel")
				var buSel = document.getElementById("buSel")
				var regionSel = document.getElementById("regionSel")
				var rlength = roleSel.options.length;
				if (rlength<role.data.length){
					role.data.map(function(data){	
						roleSel.options[roleSel.options.length] = new Option(data.RoleName, data.id);
					})
				}
				var blength = buSel.options.length;
				if (blength<1){
					for (var data in regionObject) {
						buSel.options[buSel.options.length] = new Option(data, data);
					}
				}
				buSel.onchange = function () {
					regionSel.length = 1;
					if (this.selectedIndex < 1) return; // done   
					var BU = regionObject[this.value];
					for (var key in BU) {
						regionSel.options[regionSel.options.length] = new Option(BU[key], BU[key]);
					}
				}
			});
			this.isPopupVisible = false;
			Swal.fire({
				title: 'Register New Account',
				html: '<div class="form-group">Username (Your Computer Username)<input type="text" id="username" class="form-control" placeholder="Enter Username"></input></div>' +
				'<div class="form-group">Password (Your Computer Password)<input type="password" id="password" class="form-control" placeholder="Enter your Password"></input></div>'+
				'<div class="form-group">Select Role<select name="role" id="roleSel" class="form-control" placeholder="Select Role"></select></div>'+
				'<div class="form-group">Select BU<select name="bu" id="buSel" class="form-control" placeholder="Select BU"></select></div>'+
				'<div class="form-group">Select Region<select name="REGION" id="regionSel" class="form-control" ></select></div>',
				confirmButtonText: 'Register',
				showLoaderOnConfirm: true,
				showCancelButton: true,
				preConfirm: () => {
					let username = Swal.getPopup().querySelector('#username').value;
					let role_id = Swal.getPopup().querySelector('#roleSel').value;
					let bu = Swal.getPopup().querySelector('#buSel').value;
					let region = Swal.getPopup().querySelector('#regionSel').value;
					let password = Swal.getPopup().querySelector('#password').value;
					let allvalid = true;
					if (username === '' || role_id === ''  || bu === ''  || password === "" ) {
						allvalid = false;
						Swal.showValidationMessage(`Please complete form input`)
					}
					if (allvalid){
						return CrudService.findData('register',{username: username, role_id: role_id,bu: bu,region: region,password: password })
						.then(response => {
							if (!response.status=='success') {
								throw new Error(response.message)
							}
							return response
						}).catch(error => {
							Swal.showValidationMessage(
							`Request failed: ${error.response.data.message}`
							)
						})
					}else{
						return false;
					}
				},
				allowOutsideClick: false
			}).then((result) => {
				if (result.value) {
                    var str = result.value.status;
                    var title = str.toString().replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();})
                    Swal.fire( title, result.value.message, str ).then(() => {
						this.isPopupVisible = true;
					})
                }else if (result.dismiss === Swal.DismissReason.cancel ) {
                    Swal.fire( 'Cancelled', 'Registration Cancelled',  'error').then(() => {
						this.isPopupVisible = true;
					})
                }
				
			})
		}
	}
};
</script>

<style scoped>
body {
	margin:0px !important;
	padding:0px !important;
}

label {
  display: block;
  margin-top: 10px;
}
.card-container.card {
  max-width: 400px !important;
  padding: 40px 40px;
}

.header-container.card {
  background-color: rgba(0, 100, 155, 0.90);
  color:#fff;
  max-width: 400px !important;
  padding: 5px 10px;
}
.card {
  background-color: #f7f7f7;
  padding: 0px;
  margin: 0 auto;
  -moz-border-radius: 1px;
  -webkit-border-radius: 1px;
  border-radius: 1px;
}

.profile-img-card {
  width: 96px;
  height: 96px;
  margin: 0 auto 10px;
  display: block;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
}
</style>