Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function() {
      var teams = new Ext.form.FormPanel({
          title: 'Teams',
          layout: 'fit'
      });

      var panel = new Ext.TabPanel({
          fullscreen: true,
          cardSwitchAnimation: 'slide',
          items: [teams]
      });
      
    }

});
