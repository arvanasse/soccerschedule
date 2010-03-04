User.create :name=>'Andy Vanasse', :email=>'andyvanasse@gmail.com', :password=>'6nov1993', :password_confirmation=>'6nov1993', :admin=>true

['U-08 Boys', 'U-08 Girls', 'U-10 Boys', 'U-10 Girls', 'U-12 Boys', 'U-12 Girls', 'U-14 Boys', 'U-14 Girls', 'Academy/Classic'].each{|name| Classification.create :name=>name }

[
  {'Thunder'        => 'http://carolinaelitesc.demosphere.com/teams/20208754/20652654-20208846/TEAM.html'},
  {'Lightning'      => 'http://carolinaelitesc.demosphere.com/teams/20208754/20652432-20208846/TEAM.html'},
  {'Pitch Raiders'  => 'http://carolinaelitesc.demosphere.com/teams/20208754/20686555-20208854/TEAM.html'},
  {'Rockets'        => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914384-20208854/TEAM.html'},
  {'Transformers'   => 'http://carolinaelitesc.demosphere.com/teams/20208754/20686843-20208854/TEAM.html'},
  {'Rangers'        => 'http://carolinaelitesc.demosphere.com/teams/20208754/20686259-20208854/TEAM.html'},
  {'Cosmos'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664252-20208847/TEAM.html'},
  {'Purple Thunder' => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664498-20208847/TEAM.html'},
  {'Purple Surge'   => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664144-20208847/TEAM.html'},
  {'Purple Wave'    => 'http://carolinaelitesc.demosphere.com/teams/20208754/20663935-20208847/TEAM.html'}, 
  {'Vipers'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664851-20208856/TEAM.html'},
  {'Tigers'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664767-20208856/TEAM.html'},
  {'Spurs'          => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664592-20208856/TEAM.html'},
  {'Galaxy'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914446-20208856/TEAM.html'},
  {'Wolves'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914539-20208856/TEAM.html'},
  {'Adrenaline'     => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665045-20208849/TEAM.html'},
  {'Rovers'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665235-20208849/TEAM.html'},
  {'Mustangs'       => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665361-20208849/TEAM.html'},
  {'Dynamite'       => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664970-20208849/TEAM.html'},
  {'Crush'          => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914501-20208849/TEAM.html'},
  {'Cheetahs'       => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665295-20208849/TEAM.html'},
  {'Blue Kippers'   => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665750-20208848/TEAM.html'},
  {'Cobras'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914603-20208848/TEAM.html'},
  {'Strikers'       => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665691-20208848/TEAM.html'},
  {'Tsunami'        => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665563-20208848/TEAM.html'},
  {'Hurricanes'     => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665647-20208848/TEAM.html'},
  {'Eastside Arsenal'=>'http://carolinaelitesc.demosphere.com/teams/20208754/20665877-20208848/TEAM.html'},
  {'Eagles'         => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665454-20208848/TEAM.html'},
  {'Gladiators'     => 'http://carolinaelitesc.demosphere.com/teams/20208754/20666031-20208851/TEAM.html'},
  {'Fire'           => 'http://carolinaelitesc.demosphere.com/teams/20208754/20665953-20208850/TEAM.html'},
  {'Gunners'        => 'http://carolinaelitesc.demosphere.com/teams/20208754/20914634-20208850/TEAM.html'},
  {'Tornadoes'      => 'http://carolinaelitesc.demosphere.com/teams/20208754/20664908-20208845/TEAM.html'},
  {'Academy U10 Boys' => 'http://carolinaelitesc.demosphere.com/teams/20208754/20666256-20208845/TEAM.html'},
  {'Academy U10 Girls'=> 'http://carolinaelitesc.demosphere.com/teams/20208754/20666145-20208843/TEAM.html'},
  {'Academy U11 Boys' => 'http://carolinaelitesc.demosphere.com/teams/20208754/20666339-20208845/TEAM.html'},
  {'Academy U12 Boys' => 'http://carolinaelitesc.demosphere.com/teams/20208754/20667120-20208845/TEAM.html'},
  {'Academy U11 Girls'=> 'http://carolinaelitesc.demosphere.com/teams/20208754/20666956-20208843/TEAM.html'},
  {'Academy U12 Girls'=> 'http://carolinaelitesc.demosphere.com/teams/20208754/20667045-20208843/TEAM.html'},
  {'Classic U13 Girls'=> 'http://scysa.demosphere.com/teams/20011478/20348111-20011588/TEAM.html'},
  {'Classic U14 Boys' => 'http://scysa.demosphere.com/teams/20011478/20350073-20011602/TEAM.html'}
].each do |team_info|
  team_info.each{|team, url| Team.create :name=>team_info.keys.first, :url=>url}
end

%w{Thunder Lightning}.each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-08 Girls').id)}
['Pitch Raiders', 'Rockets', 'Transformers', 'Rangers'].each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-08 Boys').id)}
['Cosmos', 'Purple Thunder', 'Purple Surge', 'Purple Wave'].each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-10 Girls').id)}
%w{Vipers Tigers Spurs Galaxy Wolves}.each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-10 Boys').id)}
%w{Adrenaline Rovers Mustangs Dynamite Crush Cheetahs}.each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-12 Girls').id)}
['Blue Kippers', 'Cobras', 'Strikers', 'Tsunami', 'Hurricanes', 'Eastside Arsenal', 'Eagles'].each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-12 Boys').id)}
%w{Gladiators}.each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-14 Girls').id)}
%w{Fire Gunners}.each{|name| Team.find_by_name(name).update_attributes(:classification_id=>Classification.find_by_name('U-14 Boys').id)}
Team.find_all_by_classification_id(nil).each{|t| t.update_attributes(:classification_id=>Classification.find_by_name('Academy/Classic').id)}
