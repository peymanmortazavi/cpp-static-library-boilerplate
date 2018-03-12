FRAMEWORK_NAME="MyLibrary"

function build {
    rm -fr tmp_project
    mkdir tmp_project
    cd tmp_project
    cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.cmake -DIOS_PLATFORM=$1 -H. -BXcode -GXcode ../../..
    cd ..
    cmake --build tmp_project/ --target ALL_BUILD --config Release
    cp -R tmp_project/Release-$2/* output/$3/
}

rm -fr output

mkdir -p output/iPhone
mkdir -p output/iPhoneSimulator

build OS iphoneos iPhone
build SIMULATOR64 iphonesimulator iPhoneSimulator

rm -fr tmp_project

cd output
mkdir Umbrella
cp -R iPhone/* Umbrella/
lipo -create iPhone/$FRAMEWORK_NAME.framework/$FRAMEWORK_NAME iPhoneSimulator/$FRAMEWORK_NAME.framework/$FRAMEWORK_NAME -output Umbrella/$FRAMEWORK_NAME.framework/$FRAMEWORK_NAME

echo "Umbrella framework made."
