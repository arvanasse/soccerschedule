Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function() {
      var loggedIn = false;
      var team_ids = [ ];

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

                              Ext.each(result.team_ids, function(team_id){
                                  Ext.getCmp('team-'+team_id).check();
                              }, this);
                              team_ids = result.teams_ids;
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

                              loggedIn = false;
                              team_ids = [ ];
                          }
                      });
                  }
              }]
          }]
      });

      Ext.regModel('Match', {
          fields: [{ 
              name: 'date', type: 'date', convert: function(val){ return Date.parseDate(val, 'c').format('F d, Y'); }
          }, {
              name: 'time', type: 'date', convert: function(val){ return Date.parseDate(val, 'c').format('g:i a'); }
          }, {
              name: 'game_time', type: 'string'
          }, {
              name: 'field', type: 'string'
          }, {
              name: 'match', type: 'string'
          }]
      });

      var schedulePanel = new Ext.Panel({
          title: 'Schedules',
          id: 'schedulePanel',
          layout: 'card',
          activeItem: 0,
          team_ids: [],
          items: [{
              xtype: 'panel',
              scroll: 'vertical',
              html: '<h2 style="display:block; text-align:center;" >Please support our Sponsors!</h2><h3 style="display:block; text-align:center; font-size: 80%; margin-bottom: 1em;">Schedules will be displayed shortly.</h3><div id="advertisement"></div>'
          }, {
              xtype: 'panel',
              items: [{
                  xtype: 'list',
                  grouped: true,
                  fullscreen: true,
                  indexBar: false,
                  itemTpl: '{game_time}, {field}<br />{match}',
                  emptyText: 'No games found.',
                  store: new Ext.data.JsonStore({
                      model: 'Match',
                      proxy: {
                          type: 'ajax',
                          url: '/schedules.json',
                          method: 'GET'
                      },
                      id: 'scheduleStore',
                      getGroupString: function(record){ return record.get('date'); }
                  })
              }]
          }],
          listeners: {
              activate: {
                  scope: this,
                  fn: function(){
                      Ext.getCmp('schedulePanel').setActiveItem(0); 
                      Ext.Ajax.request({
                          url: '/advertisements/random',
                          success: function(resp){
                              target = Ext.get('advertisement'); 
                              target.setHTML( resp.responseText );
                              var task = new Ext.util.DelayedTask(function(){ 
                                  Ext.StoreMgr.get('scheduleStore').load();
                                  Ext.getCmp('schedulePanel').setActiveItem(1); 
                              });
                              task.delay(15000);
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
                    fields.push({ 
                        xtype: 'checkboxfield', 
                        labelWidth: 200, 
                        name: name, 
                        id: 'team-'+team_info.id, 
                        value: team_info.id, 
                        label: team_info.name,
                        listeners: {
                            check: {
                                scope: this,
                                fn: function(chk){ 
                                    schedulePanel.team_ids.push(team_info.id);
                                    Ext.Ajax.request({
                                        url: '/team_followers.json',
                                        jsonData: { team_follower: { team_id: schedulePanel.team_ids } }
                                    });
                                }
                            },
                            uncheck: {
                                scope: this,
                                fn: function(chk){ 
                                    schedulePanel.team_ids.splice(schedulePanel.team_ids.indexOf(team_info.id), 1);
                                    Ext.Ajax.request({
                                        url: '/team_followers/' + team_info.id + '.json',
                                        method: 'DELETE'
                                    });
                                }
                            }
                        } 
                    });
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
