# -*- coding: utf-8 -*-
#$:.unshift("/Library/RubyMotion/lib")
$:.unshift("/Library/RubyMotion2.17/lib")
require 'motion/project/template/ios'
require 'formotion'
require 'rubygems'
require 'motion-fontawesome'
require 'motion-pixate'
require 'motion-cocoapods'

#require 'sugarcube'
#require 'sugarcube-color'
#require 'sugarcube-image'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'honeys_call'

  # Twillio SDK
  app.vendor_project('vendor/twillio-SDK',
                      :static,
                      :products => ['Libraries/libcrypto.a', 'Libraries/libssl.a', 'Libraries/libTwilioClient.a'],
                      :headers_dir => 'Headers')
  app.frameworks += %w(AudioToolbox CFNetwork AVFoundation SystemConfiguration QuartzCore CoreText)
  #pixateのライセンス
  app.pixate.user = 'yuki.moriyaman@gmail.com'
  app.pixate.key  = 'JEOH1-UJL0Q-LBTQC-2PUA3-T6JNV-5DKFU-1HDV4-APV7Q-FV1TU-2CHUC-6HQL2-ILKK6-O8E30-HGKHJ-ED59K-IC'

  app.pixate.framework = 'vendor/Pixate.framework' 
  app.libs += %W(/usr/lib/libz.dylib /usr/lib/libsqlite3.dylib)

  app.pods do
    pod 'EGOTableViewPullRefresh'
    pod 'MGBoxKit'
  end
  
end
