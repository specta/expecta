require 'tmpdir'
require 'pathname'

PROJECT = 'Expecta.xcodeproj'
CONFIGURATION = 'Release'

NO_COLOR= "\033[0m"
GREEN_COLOR = "\033[32;01m"

def xcpretty_available
  `gem list xcpretty -i`.chomp == 'true'
end

def code_sign_identity
  ENV["CODE_SIGN_IDENTITY"] ||
    ENV['EXP_CODE_SIGNING_IDENTITY'] ||
    'iPhone Developer'
end

def execute(command, stdout=nil)
  puts "Running #{command}..."
  command += " > #{stdout}" if stdout
  system(command) or raise "** BUILD FAILED **"
end

def test(scheme)
  cmd = "xcrun xcodebuild -derivedDataPath build SYMROOT=build -project #{PROJECT} -scheme #{scheme} -configuration #{CONFIGURATION} test"
  if xcpretty_available
    cmd = "#{cmd} | xcpretty -c && exit ${PIPESTATUS[0]}"
  end
  execute cmd
end

def ios_simulator_destination
  "-destination 'platform=iOS Simulator,name=iPhone 5,OS=latest'"
end

def build(scheme, sdk, product)
  destination = ''
  build_dir = CONFIGURATION
  if sdk != 'macosx'
    build_dir = "#{CONFIGURATION}-#{sdk}"
    if sdk == 'iphonesimulator'
      destination = ios_simulator_destination
    end
  end
  cmd = "xcrun xcodebuild -derivedDataPath build SYMROOT=build -project #{PROJECT} -scheme #{scheme} -sdk #{sdk} #{destination} -configuration #{CONFIGURATION}"
  if xcpretty_available
    cmd = "#{cmd} | xcpretty -c && exit ${PIPESTATUS[0]}"
  end
  execute cmd
  "build/#{build_dir}/#{product}"
end

def build_framework(scheme, sdk)
  build(scheme, sdk, 'Expecta.framework')
end

def build_static_lib(scheme, sdk)
  build(scheme, sdk, 'libExpecta.a')
end

def lipo(bin1, bin2, output)
  execute "xcrun lipo -create '#{bin1}' '#{bin2}' -output '#{output}'"
end

def generate_universal_framework(platform, output_dir, framework_simulator, framework_device)
  puts_green "\n=== GENERATE UNIVERSAL #{platform} FRAMEWORK (Device/Simulator) ==="
  execute "mkdir -p '#{output_dir}'"
  execute "cp -a '#{framework_device}' '#{output_dir}'"

  framework_name = Pathname.new(framework_device).basename.to_s
  universal_framework  = File.join(output_dir, framework_name)

  lipo("#{framework_device}/Expecta", "#{framework_simulator}/Expecta", "#{universal_framework}/Expecta")

  puts_green "\n=== CODESIGN #{platform} FRAMEWORK ==="
  execute "xcrun codesign --force --sign \"#{code_signing_identity}\" '#{universal_framework}'"

  "#{universal_framework}"
end

def generate_universal_static_library(platform, output_dir, static_library_simulator, static_library_device)
  puts_green "\n=== GENERATE UNIVERSAL #{platform} STATIC LIBRARY (Device/Simulator) ==="
  execute "mkdir -p '#{output_dir}'"
  execute "cp -a '#{static_library_device}' '#{output_dir}'"

  static_library_name = Pathname.new(static_library_device).basename.to_s
  universal_static_library = File.join(output_dir, static_library_name)
  lipo(static_library_device, static_library_simulator, universal_static_library)

  "#{universal_static_library}"
end

def puts_green(str)
  puts "#{GREEN_COLOR}#{str}#{NO_COLOR}"
end

desc 'Run tests'
task :test do |t|
  execute "xcrun xcodebuild test -project #{PROJECT} -scheme Expecta"
end

desc 'clean'
task :clean do |t|
  puts_green '=== CLEAN ==='
  execute 'rm -rf build'
  execute 'rm -rf Expecta/build'
  execute 'rm -rf Expecta/Products'
end

desc 'build'
task :build => :clean do |t|
  puts_green "=== BUILD ==="

  osx_framework       = build_framework('Expecta', 'macosx')
  ios_sim_framework   = build_framework('Expecta-iOS', 'iphonesimulator')
  ios_framework       = build_framework('Expecta-iOS', 'iphoneos')
  tvos_sim_framework  = build_framework('Expecta-tvOS', 'appletvsimulator')
  tvos_framework      = build_framework('Expecta-tvOS', 'appletvos')

  osx_static_lib      = build_static_lib('libExpecta', 'macosx')
  ios_sim_static_lib  = build_static_lib('libExpecta-iOS', 'iphonesimulator')
  ios_static_lib      = build_static_lib('libExpecta-iOS', 'iphoneos')

  # ios_build_path = Pathname.new(ios_framework).parent.to_s
  ios_univ_build_path = "Expecta/build/#{CONFIGURATION}-ios-universal"
  ios_univ_framework = generate_universal_framework("iOS", ios_univ_build_path, ios_sim_framework, ios_framework)
  ios_univ_static_lib = generate_universal_static_library("iOS", ios_univ_build_path, ios_sim_static_lib, ios_static_lib)
  tvos_univ_build_path = "Expecta/build/#{CONFIGURATION}-tvos-universal"
  tvos_univ_framework = generate_universal_framework("tvOS", tvos_univ_build_path, tvos_sim_framework, tvos_framework)

  # puts_green "\n=== GENERATE UNIVERSAL iOS BINARY (Device/Simulator) ==="
  # execute "mkdir -p '#{ios_univ_build_path}'"
  # execute "cp -a '#{ios_framework}' '#{ios_univ_build_path}'"
  # execute "cp -a '#{ios_static_lib}' '#{ios_univ_build_path}'"
  #
  # ios_framework_name = Pathname.new(ios_framework).basename.to_s
  # ios_static_lib_name = Pathname.new(ios_static_lib).basename.to_s
  #
  # ios_univ_framework  = File.join(ios_univ_build_path, ios_framework_name)
  # ios_univ_static_lib = File.join(ios_univ_build_path, ios_static_lib_name)
  #
  # lipo("#{ios_framework}/Expecta", "#{ios_sim_framework}/Expecta", "#{ios_univ_framework}/Expecta")
  # lipo(ios_static_lib, ios_sim_static_lib, ios_univ_static_lib)
  #
  # puts_green "\n=== CODESIGN iOS FRAMEWORK ==="
  # execute "xcrun codesign --force --sign \"#{code_sign_identity}\" '#{ios_univ_framework}'"



  puts_green "\n=== COPY PRODUCTS ==="
  execute "yes | rm -rf Products"
  execute "mkdir -p Products/ios"
  execute "mkdir -p Products/osx"
  execute "mkdir -p Products/tvos"

  execute "cp -a #{osx_framework} Products/osx"
  execute "cp -a #{osx_static_lib} Products/osx"
  execute "cp -a #{ios_univ_framework} Products/ios"
  execute "cp -a #{ios_univ_static_lib} Products/ios"
  execute "cp -a #{tvos_univ_framework} Products/tvos"

  execute "cp -a #{osx_framework}/Headers/* Products"
  puts "\n** BUILD SUCCEEDED **"
end

namespace 'specs' do
  task :ios => :clean do |t|
    test("Expecta-iOS")
  end

  task :osx => :clean do |t|
    test("Expecta")
  end

  task :tvos => :clean do |t|
    test("Expecta-tvOS")
  end
end

task :default => [:build]
