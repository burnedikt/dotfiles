
# Find out the platform on which we're running
function platform {

  platform="unknown"
  unamestr=`uname | awk '{print tolower($0)}'`

  if [[ "$unamestr" == "linux" ]]; then
    platform="linux"
  elif [[ "$unamestr" == "freebasd" ]]; then
    platform="freebsd"
  elif [[ "$unamestr" == "darwin" ]]; then
    platform="macos"
  elif [[ "$unamestr" == *"cygwin"* ]]; then
    platform="cygwin"
  elif [[ "$unamestr" == *"mingw"* ]]; then
    platform="mingw"
  fi
  echo $platform
}
