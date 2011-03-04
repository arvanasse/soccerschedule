Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function() {
      var loggedIn = false;

      var teams = new Ext.Carousel({
          title: 'Teams',
          layout: 'fit'
      });

      var loginPanel = new Ext.form.FormPanel({
          title: 'Login',
          items: [{
              xtype: 'emailfield',
              label: 'Email',
              name: 'user_session[email]'
          }, {
              xtype: 'passwordfield',
              label: 'Password',
              name: 'user_session[password]'
          }, {
              xtype: 'panel',
              html: '<p id="user-name"></p>'
          }],
          dockedItems: [{
              xtype: 'toolbar',
              dock: 'top',
              items: [{
                  text: 'Login',
                  ui: 'confirm',
                  id: 'loginButton',
                  handler: function(btn){
                      btn.ownerCt.ownerCt.submit({
                          url: '/session.json',
                          scope: this,
                          success: function(frm, result){ 
                              loggedIn = true; 
                              Ext.Msg.alert('Logged In', 'Welcome back, '+result.user); 
                              Ext.get('user-name').setHTML('You are logged in as ' + result.user );
                              Ext.getCmp('loginButton').hide();
                              Ext.getCmp('logoutButton').show();
                          },
                          failure: function(){ Ext.Msg.alert('Login Failed', 'You could not be logged in with the information provided.', Ext.emptyFn); }
                      });
                  }
              }, {
                  text: 'Logout',
                  ui: 'decline',
                  id: 'logoutButton',
                  hidden: true,
                  handler: function(){
                      Ext.Ajax.request({
                          url: '/session.json',
                          method: 'DELETE',
                          success: function(resp){
                              Ext.Msg.alert('Logged Out', 'You have been logged out.');
                              Ext.get('user-name').setHTML('' );
                              Ext.getCmp('loginButton').show();
                              Ext.getCmp('logoutButton').hide();
                          }
                      });
                  }
              }]
          }]
      });


      var schedulePanel = new Ext.Panel({
          title: 'Schedules',
          layout: 'card',
          activeItem: 0,
          items: [{
              xtype: 'panel',
              scroll: 'vertical',
              html: '<h2 style="display:block; text-align:center;" >Please support our Sponsors!</h2><h3 style="display:block; text-align:center; font-size: 80%; margin-bottom: 1em;">Schedules will be displayed shortly.</h3><div id="advertisement"></div>'
          }, {
              xtype: 'panel',
              html: '<div id="schedules"></div>'
          }],
          listeners: {
              activate: {
                  scope: this,
                  fn: function(){
                      Ext.Ajax.request({
                          url: '/advertisements/random',
                          success: function(resp){
                             target = Ext.get('advertisement'); 
                             target.setHTML( resp.responseText );
                          }
                      });
                  }
              }
          }
      });

      var panel = new Ext.TabPanel({
          fullscreen: true,
          cardSwitchAnimation: 'slide',
          items: [ teams, schedulePanel, {xtype: 'spacer'}, loginPanel ]
      });

      Ext.Ajax.request({
          url: Routing.classifications_path({ format: 'json' }),
          success: function(response, opts){
            var teamBar = [ ];
            var classification_info = Ext.decode( response.responseText );

            Ext.each(classification_info, function(classification){

              fields = [ ];
              Ext.each(classification.teams, function(team_info){
                if( team_info.state == 'visible' ){
                    name = 'team_followers[' + team_info.id + '][team_id]';
                    fields.push({ xtype: 'checkboxfield', labelWidth: 200, name: name, value: team_info.id, label: team_info.name });
                }
              }, this);

              classificationId = 'classification_' + classification.id;
              fs = teams.add({ xtype: 'form', layout: 'auto', scroll: 'vertical', items: [{ xtype: 'fieldset', title: classification.name, items: fields, id: classificationId }] });
            }, this);

            teams.doLayout();
          }
      });
      
    }
});
