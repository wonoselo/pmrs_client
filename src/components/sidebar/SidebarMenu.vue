<script>
const sidebarMenu = [
  { path: '/dashboard', icon: 'fa fa-th', title: 'Dashboard' },
  { path: '/admin', icon: 'fa fa-cog', title: 'Admin Area',
    children: [
      { path: '/admin/user', title: 'Manage User' },
      { path: '/admin/role', title: 'Manage Role' },
      { path: '/admin/module', title: 'Manage Module' },
      { path: '/admin/accessrole', title: 'Manage Role Access' }
    ]
  },
  /*{ path: '/report', icon: 'fa fa-align-left', title: 'Report', label: 'NEW', badge: '10', 
    children: [
      { path: '/report/wip', title: 'WIP',
        children: [
          { path: '/report/wip/menu-2-1', title: 'Menu 2.1',
            children: [
              { path: '/report/wip/menu-2-1/menu-3-1', title: 'Menu 3.1' },
              { path: '/report/wip/menu-2-1/menu-3-2', title: 'Menu 3.2' }
            ]
          },
          { path: '/report/wip/menu-2-2', title: 'Menu 2.2' },
          { path: '/report/wip/menu-2-3', title: 'Menu 2.3' },
        ]
      },
      { path: '/report/mdr', title: 'MDR' },
      { path: '/report/pma', title: 'PMA' },
    ]
  },*/
  { path: '/logout', icon: 'fa fa-power-off', title: 'Logout' },
]

export default sidebarMenu;
</script>
