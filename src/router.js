import Swal from 'sweetalert2';
import Vue from 'vue';
import Router from 'vue-router';
import crudService from './services/crud.service';
import Dashboard from './views/Dashboard.vue';
import Login from './views/Login.vue';
Vue.use(Router);

export const router = new Router({
  mode: 'hash',
  base: '/pmrs/',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Dashboard,
    },
    {
      path: '/home',
      component: Dashboard
    },
    {
      path: '/login',
      component: Login,
      props: {
        layout: {
          title: 'Sign In',
        },
      },
    },
    {
      path: '/logout',
      name: 'logout',
      component: () => import('./views/Logout.vue'),
    },
    {
      path: '/profile',
      name: 'profile',
      component: () => import('./views/Profile.vue'),
    },

    {
      path: '/summaryval',
      name: 'summaryval',
      component: () => import('./views/SummaryValidasi.vue'),
    },

    {
      path: '/summaryvalnew',
      name: 'summaryvalnew',
      component: () => import('./views/SummaryValidasiNew.vue'),
    },

    {
      path: '/closinggis',
      name: 'closinggis',
      component: () => import('./views/closinggis/ClosingGIS.vue'),
    },
    
    {
      path: '/summary/closinggis',
      name: 'summaryclosinggis',
      component: () => import('./views/closinggis/SummaryClosingGIS.vue'),
    }

  ],
});

router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('user');
  const logoutPages = ['/logout'];

  if (authRequired && !loggedIn) {
    if (logoutPages.includes(to.path)) {
      return next({ path: '/login' });
    } else {
      return next({ path: '/login', query: { redirect: to.path || "/dashboard" } });
    }

  }

  if (to.matched.some(route => route.meta.module)) {
    crudService.findData('accessroles/check',{ module: to.meta.module }).then(response => {
    	if (response.data.AllowView || response.isadmin) {
    		next();
    	}else{
    		Swal.fire({
    			icon: 'error',
    			title: 'Oops...',
    			text: "You don't have access to view the page"
    		})
    		next("/dashboard");
    	}
    	return
    });
  }

  if (to.matched.some(route => route.meta.requireAdmin)) {
    var user = JSON.parse(loggedIn)
    if (!user.user.isAdmin) {
      next("/dashboard");
    } else {
      next();
    }
    return
  }
  next();
});
export default router
