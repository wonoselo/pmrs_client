<template>
  <div v-if="!isLoading">
    <div
      id="app"
      class="fade page-sidebar-fixed page-header-fixed show page-container"
      v-if="currentUser && !pageOptions.pageEmpty"
      v-bind:class="{
        'page-sidebar-minified': pageOptions.pageSidebarMinified,
        'page-content-full-height': pageOptions.pageContentFullHeight,
        'page-without-sidebar': pageOptions.pageWithoutSidebar,
        'page-with-right-sidebar': pageOptions.pageWithRightSidebar,
        'page-with-two-sidebar': pageOptions.pageWithTwoSidebar,
        'page-with-wide-sidebar': pageOptions.pageWithWideSidebar,
        'page-with-light-sidebar': pageOptions.pageWithLightSidebar,
        'page-with-top-menu': pageOptions.pageWithTopMenu,
        'page-sidebar-toggled': pageOptions.pageMobileSidebarToggled,
        'page-right-sidebar-toggled':
          pageOptions.pageMobileRightSidebarToggled ||
          pageOptions.pageRightSidebarToggled,
        'page-right-sidebar-collapsed': pageOptions.pageRightSidebarCollapsed,
        'has-scroll': pageOptions.pageBodyScrollTop,
      }"
    >
      <Header v-if="currentUser" />
      <TopMenu v-if="currentUser && pageOptions.pageWithTopMenu" />
      <Sidebar v-if="currentUser && !pageOptions.pageWithoutSidebar" />
      <SidebarRight v-if="currentUser && pageOptions.pageWithTwoSidebar" />
      <div
        id="content"
        class="content"
        v-bind:class="{
          'content-full-width': pageOptions.pageContentFullWidth,
          'content-inverse-mode': pageOptions.pageContentInverseMode,
        }"
      >
        <router-view></router-view>
      </div>
      <Footer v-if="currentUser && pageOptions.pageWithFooter" />
    </div>
    <div class="h-100" v-else>
      <router-view></router-view>
    </div>
  </div>
  <div v-else>
    <vue-ins-progress-bar ></vue-ins-progress-bar>
  </div>
</template>

<script>
import Sidebar from './components/sidebar/Sidebar.vue';
import SidebarRight from './components/sidebar-right/SidebarRight.vue';
import Header from './components/header/Header.vue';
import TopMenu from './components/top-menu/TopMenu.vue';
import Footer from './components/footer/Footer.vue';
import PageOptions from './config/PageOptions.vue';

import NotFoundComponent from './views/NotFound.vue';
import CrudService from './services/crud.service';

export default {
  components: {
    Sidebar,
    SidebarRight,
    Header,
    TopMenu,
    Footer,
  },
  data() {
    return {
      active: false,
      isLoading: true,
      pageOptions: PageOptions,
    };
  },
  computed: {
    isAdmin() {
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
    logOut() {
      this.$store.dispatch('auth/logout');
      this.$router.push({
        path: '/login',
        query: { redirect: this.$route.path },
      });
    },
    toggleNavClass() {
      if (this.active == false) {
        return 'nav';
      } else {
        return 'sticky-nav';
      }
    },
    handleScroll: function () {
      PageOptions.pageBodyScrollTop = window.scrollY;
    },
  },
  mounted() {
    this.$insProgress.finish();
  },
  created() {
    PageOptions.pageBodyScrollTop = window.scrollY;
    PageOptions.pageWithFooter = true;
    PageOptions.pageSidebarTransparent = true;

    window.addEventListener('scroll', this.handleScroll);

    this.$insProgress.start();

    this.$router.beforeEach((to, from, next) => {
      this.$insProgress.start();
      next();
    });

    this.$router.afterEach(() => {
      this.$insProgress.finish();
    });

    CrudService.getAll('modules').then((response) => {
      let modules = response.data;
      let router = this.$router;

      modules.forEach(function (menu) {
        if (menu.router !== null && menu.router !== '') {
          let newRoute = {
            path: menu.Path,
            name: menu.router,
            component: () => import(`./views/${menu.component}.vue`),
          };
          if (menu.isNeedCheckAccess) {
            newRoute.meta = { module: menu.ModuleName };
          }
          router.addRoutes([newRoute]);
        }
      });

      let newRoute = { path: '*', component: NotFoundComponent };
      this.$router.addRoutes([newRoute]);
      this.isLoading = false;
    });
  },
};
</script>

<style>
body {
  background-color: #dee2e6 !important;
}
</style>
