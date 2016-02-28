# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'xcom2-mod-manager'
  app.info_plist['NSUIElement'] = 1

  app.short_version = app_version = '0.2'

  app.pods do
   pod 'OGIniFiler', git: 'https://github.com/scally/OGIniFiler.git'
 end
end
