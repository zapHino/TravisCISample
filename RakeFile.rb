WORKSPACE = 'TravisCISample.xcworkspace'
SCHEME = 'TravisCISample'
PRODUCT_NAME = 'Travis'
BUILD_DIR = 'build'

desc 'ビルドディレクトリを削除し、クリーンを実行する'
task :clean do
  # ビルドディレクトリが存在する場合は削除する
  rm_rf(BUILD_DIR) if File.exist?(BUILD_DIR)

  # 実行するコマンドを準備する
  # パイプの途中でエラーがあった場合はエラーとして扱うコマンド
  pipeCommand = "set -o pipefail"

  # クリーンを行うコマンド
  cleanCommand = "xcodebuild clean"

  # xcodebuildのログをきれいにするコマンド
  formatCommand = "xcpretty -c"

  # 各コマンドを連結して実行 
  sh "#{pipeCommand} && #{cleanCommand} | #{formatCommand}"
end

desc 'テストを実行するコマンド'
task :test do
  # 実行するコマンドを準備する
  # パイプの途中でエラーがあった場合はエラーとして扱うコマンド
  pipeCommand = "set -o pipefail"

  # テストを行うコマンド
  testCommand = "xcodebuild test\
    -configuration Debug\
    -sdk iphonesimulator\
    -workspace #{WORKSPACE}\
    -scheme #{SCHEME}\
    -destination 'platform=iOS Simulator,name=iPhone 6'"
  
  # xcodebuildのログをきれいにするコマンド
  formatCommand = "xcpretty -c"
  
  # 各コマンドを連結して実行
  sh "#{pipeCommand} && #{testCommand} | #{formatCommand}"
end
