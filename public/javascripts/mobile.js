Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function() {
      var teamSelector = new Ext.form.FormPanel({
          layout: 'card'
      });

      var teams = new Ext.Panel({
          title: 'Teams',
          layout: 'fit',
          items: [ teamSelector ]
      });

      var panel = new Ext.TabPanel({
          fullscreen: true,
          cardSwitchAnimation: 'slide',
          items: [ teams ]
      });

      Ext.Ajax.request({
          url: Routing.classifications_path({ format: 'json' }),
          success: function(response, opts){
            var teamBar = [ ];
            var classification_info = Ext.decode( response.responseText );

            Ext.each(classification_info, function(classification){

              fields = [ ];
              Ext.each(classification.teams, function(team_info){
                name = 'team_followers[' + team_info.id + '][team_id]';
                fields.push({ xtype: 'checkboxfield', name: name, value: team_info.id, label: team_info.name });
              }, this);

              classificationId = 'classification_' + classification.id;
              fs = teamSelector.add({ xtype: 'fieldset', title: classification.name, items: fields, id: classificationId  });

              teamBar.push({ 
                  text: classification.name,
                  iconCls: 'favorite',
                  handler: function(btn, evt){ teamSelector.setActiveItem( 'classification_'+classification.id ); }
              });

            }, this);
            teams.addDocked( new Ext.TabBar({ ui: 'dark', dock: 'bottom', items: teamBar }) );
            teams.doLayout();
          }
      });
      
    }
});
