Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function() {
      var teams = new Ext.Carousel({
          title: 'Teams',
          layout: 'fit'
      });

      var loginPanel = new Ext.form.FormPanel({
          title: 'Login',
          items: [{
              xtype: 'emailfield',
              label: 'Email'
          }, {
              xtype: 'passwordfield',
              label: 'Password'
          }],
          dockedItems: [{
              xtype: 'toolbar',
              dock: 'top',
              items: [{
                  text: 'Login',
                  ui: 'confirm'
              }]
          }]
      });


      var schedulePanel = new Ext.Panel({
          title: 'Schedules',
          html: '<div id="advertisement"></div>'
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
