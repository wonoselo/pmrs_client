<template>
	<div>
		<!-- begin #header -->
		<div id="header" class="header navbar-default">
			<!-- begin navbar-header -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle pull-left" v-on:click="toggleMobileRightSidebar" v-if="pageOptions.pageWithTwoSidebar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<router-link to="/dashboard" class="navbar-brand"><img src="favicon.png" alt="homepage" style="height:50px;" class="light-logo">  <b>PMRS </b>::Planning Monitoring & Reporting System</router-link>
				<button type="button" class="navbar-toggle pt-0 pb-0 mr-0 collapsed" v-on:click="toggleMobileTopMenu" v-if="pageOptions.pageWithTopMenu && !pageOptions.pageWithoutSidebar">
					<span class="fa-stack fa-lg text-inverse">
						<i class="far fa-square fa-stack-2x"></i>
						<i class="fa fa-cog fa-stack-1x"></i>
					</span>
				</button>
				<button type="button" class="navbar-toggle" v-on:click="toggleMobileTopMenu" v-if="pageOptions.pageWithTopMenu && pageOptions.pageWithoutSidebar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<button type="button" class="navbar-toggle p-0 m-r-0" v-on:click="toggleMobileMegaMenu" v-if="pageOptions.pageWithMegaMenu">
					<span class="fa-stack fa-lg text-inverse m-t-2">
						<i class="far fa-square fa-stack-2x"></i>
						<i class="fa fa-cog fa-stack-1x"></i>
					</span>
				</button>
				<button type="button" class="navbar-toggle" v-on:click="toggleMobileSidebar" v-if="!pageOptions.pageWithoutSidebar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<!-- end navbar-header -->
			
			<header-mega-menu v-if="pageOptions.pageWithMegaMenu"></header-mega-menu>
		
			<!-- begin header-nav -->
			<ul class="navbar-nav navbar-right">
				<!-- <li class="navbar-form">
					<form name="search_form" v-on:submit="checkForm">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Enter keyword" />
							<button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
						</div>
					</form>
				</li> -->
				<!-- <b-nav-item-dropdown menu-class="media-list dropdown-menu-right" toggle-class="f-s-14" no-caret>
					<template slot="button-content">
						<i class="fa fa-bell"></i>
						<span class="label">5</span>
					</template>
					<b-dropdown-header>NOTIFICATIONS (5)</b-dropdown-header>
					<b-dropdown-item href="javascript:;" class="media">
						<div class="d-flex">
							<div class="media-left">
								<i class="fa fa-bug media-object bg-silver-darker"></i>
							</div>
							<div class="media-body">
								<h6 class="media-heading">Server Error Reports <i class="fa fa-exclamation-circle text-danger"></i></h6>
								<div class="text-muted f-s-10">3 minutes ago</div>
							</div>
						</div>
					</b-dropdown-item>
					<b-dropdown-item href="javascript:;" class="media">
						<div class="d-flex">
							<div class="media-left">
								<img src="favicon.png" class="media-object" alt="" />
								<i class="fab fa-facebook-messenger text-blue media-object-icon"></i>
							</div>
							<div class="media-body">
								<h6 class="media-heading">John Smith</h6>
								<p>Quisque pulvinar tellus sit amet sem scelerisque tincidunt.</p>
								<div class="text-muted f-s-10">25 minutes ago</div>
							</div>
						</div>
					</b-dropdown-item>
					<b-dropdown-item href="javascript:;" class="media">
						<div class="d-flex">
							<div class="media-left">
								<img src="favicon.png" class="media-object" alt="" />
								<i class="fab fa-facebook-messenger text-blue media-object-icon"></i>
							</div>
							<div class="media-body">
								<h6 class="media-heading">Olivia</h6>
								<p>Quisque pulvinar tellus sit amet sem scelerisque tincidunt.</p>
								<div class="text-muted f-s-10">35 minutes ago</div>
							</div>
						</div>
					</b-dropdown-item>
					<b-dropdown-item href="javascript:;" class="media">
						<div class="d-flex">
							<div class="media-left">
								<i class="fa fa-plus media-object bg-silver-darker"></i>
							</div>
							<div class="media-body">
								<h6 class="media-heading"> New User Registered</h6>
								<div class="text-muted f-s-10">1 hour ago</div>
							</div>
						</div>
					</b-dropdown-item>
					<b-dropdown-item href="javascript:;" class="media">
						<div class="d-flex">
							<div class="media-left">
								<i class="fa fa-envelope media-object bg-silver-darker"></i>
								<i class="fab fa-google text-warning media-object-icon f-s-14"></i>
							</div>
							<div class="media-body">
								<h6 class="media-heading"> New Email From John</h6>
								<div class="text-muted f-s-10">2 hour ago</div>
							</div>
						</div>
					</b-dropdown-item>
					<b-dropdown-item href="javascript" class="text-center">
						<a href="javascript:;">View more</a>
					</b-dropdown-item>
				</b-nav-item-dropdown> -->
				<b-nav-item-dropdown menu-class="navbar-language" no-caret  v-if="pageOptions.pageWithLanguageBar">
					<template slot="button-content">
						<span class="flag-icon flag-icon-us mr-1" title="us"></span>
						<span class="name d-none d-sm-inline mr-1">EN</span> <b class="caret"></b>
					</template>
					<b-dropdown-item href="javascript:;"><span class="flag-icon flag-icon-us" title="us"></span> English</b-dropdown-item>
					<b-dropdown-item href="javascript:;"><span class="flag-icon flag-icon-cn" title="cn"></span> Chinese</b-dropdown-item>
					<b-dropdown-item href="javascript:;"><span class="flag-icon flag-icon-jp" title="jp"></span> Japanese</b-dropdown-item>
					<b-dropdown-item href="javascript:;"><span class="flag-icon flag-icon-be" title="be"></span> Belgium</b-dropdown-item>
					<b-dropdown-divider class="m-b-0"></b-dropdown-divider>
					<b-dropdown-item href="javascript:;" class="text-center">more options</b-dropdown-item>
				</b-nav-item-dropdown>
				<b-nav-item-dropdown menu-class="dropdown-menu-right" class="dropdown navbar-user" no-caret>
					<template slot="button-content">
						<!-- <img src="favicon.png" alt="" /> -->
						<i class="fa fa-user"></i> &nbsp;
						<span class="d-none d-md-inline">{{ currentUser.user.fullname }} </span> <b class="caret"></b>
					</template>
					<!-- <b-dropdown-item href="#/profile"><i class="fa fa-user"></i> View Profile</b-dropdown-item> -->
					<!-- <b-dropdown-item href="javascript:;"><i class="fa fa-envelope"></i> <span class="badge badge-danger pull-right">0</span> Inbox</b-dropdown-item> -->
					<!--<b-dropdown-item href="javascript:;" @click="changePass"><i class="fa fa-cog"></i> Change Password </b-dropdown-item>-->
					<b-dropdown-divider></b-dropdown-divider>
					<b-dropdown-item href="#/logout"><i class="fa fa-power-off"></i> Log Out</b-dropdown-item>
				</b-nav-item-dropdown>
				<li class="divider d-none d-md-block" v-if="pageOptions.pageWithTwoSidebar"></li>
				<li class="d-none d-md-block" v-if="pageOptions.pageWithTwoSidebar">
					<a href="javascript:;" v-on:click="toggleRightSidebarCollapsed" class="f-s-14">
						<i class="fa fa-th"></i>
					</a>
				</li>
			</ul>
			<!-- end header navigation right -->
		</div>
		<!-- end #header -->
	</div>
</template>

<script>
import PageOptions from '../../config/PageOptions.vue'
import HeaderMegaMenu from './HeaderMegaMenu.vue'
import Swal from 'sweetalert2'
import CrudService from '../../services/crud.service';
export default {
  name: 'Header',
	components: {
		HeaderMegaMenu
	},
  data() {
		return {
			pageOptions: PageOptions
		}
	},
	computed: {
		isAdmin(){
			if (this.currentUser) {
				return this.currentUser.user.isAdmin;
			}
			return false;
		},
		currentUser() {
			return this.$store.state.auth.user;
		},
	},
	methods: {
		toggleMobileSidebar() {
			this.pageOptions.pageMobileSidebarToggled = !this.pageOptions.pageMobileSidebarToggled;
		},
		toggleMobileRightSidebar() {
			this.pageOptions.pageMobileRightSidebarToggled = !this.pageOptions.pageMobileRightSidebarToggled;
		},
		toggleMobileTopMenu() {
			this.pageOptions.pageMobileTopMenu = !this.pageOptions.pageMobileTopMenu;
		},
		toggleMobileMegaMenu() {
			this.pageOptions.pageMobileMegaMenu = !this.pageOptions.pageMobileMegaMenu;
		},
		toggleRightSidebar() {
			this.pageOptions.pageRightSidebarToggled = !this.pageOptions.pageRightSidebarToggled;
		},
		toggleRightSidebarCollapsed() {
			this.pageOptions.pageRightSidebarCollapsed = !this.pageOptions.pageRightSidebarCollapsed;
		},
		checkForm: function(e) {
			e.preventDefault();
			this.$router.push({ path: '/extra/search' })
		},
		changePass : ()=>{
			Swal.fire({
                title: 'Change Password',
                html: '<input type="password" id="oldpassword" class="swal2-input" placeholder="Enter Current Password"></input>' +
                  '<input type="password" id="newpassword" class="swal2-input" placeholder="Enter your new password"></input>'+
                  '<input type="password" id="newpassword_confirmation" class="swal2-input" placeholder="Enter your new password confirmation"></input>',
                confirmButtonText: 'Change Password',
                showLoaderOnConfirm: true,
                showCancelButton: true,
                preConfirm: () => {
                  let oldpassword = Swal.getPopup().querySelector('#oldpassword').value;
                  let newpassword = Swal.getPopup().querySelector('#newpassword').value;
                  let newpassword_confirmation = Swal.getPopup().querySelector('#newpassword_confirmation').value;
                  let allvalid = true;
                  if (oldpassword === '' || newpassword === '' || newpassword_confirmation === '') {
                    allvalid = false;
                    Swal.showValidationMessage(`Please complete form input`)
                  }
                  if (newpassword !== newpassword_confirmation) {
                      allvalid = false;
                      Swal.showValidationMessage(`Password confirmation is not match`)
                  }
                  if (allvalid){
					return CrudService.findData('changepass',{oldpassword: oldpassword, newpassword: newpassword,newpassword_confirmation:newpassword_confirmation })
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
                    Swal.fire( title, result.value.message, str )
                }else if (result.dismiss === Swal.DismissReason.cancel ) {
                    Swal.fire( 'Cancelled', 'Your password is not changed',  'error')
                }
              })
		}
	}
}
</script>

