Pod::Spec.new do |s|

s.name         = 'CDRFlowButton'
s.version      = '0.0.1'
s.summary      = "CDRFLow button, adds three spring animated buttons to have a more dynamic app"
s.homepage     = 'https://github.com/cristi1900/CDRFlowButton'
s.platform     = :ios, '8.0'
s.license      = { :type => 'MIT' }
s.author       = { "Cristian Raica" => "cristiandraica@gmail.com" }
s.source       = { :git => "https://github.com/cristi1900/CDRFlowButton.git", :commit => "8cb3b21d0844059f909e24dec2658a498615536a" }
s.dependency "JTHamburgerButton" , '~> 1.0'
s.requires_arc = true
s.source_files = 'CDRFlowButtonExample/CDRFlowButtonExample/Classes/*'

end
