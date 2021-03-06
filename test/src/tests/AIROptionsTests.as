package tests
{
	import com.nextgenactionscript.asconfigc.AIROptions;
	import com.nextgenactionscript.asconfigc.AIROptionsParser;
	import com.nextgenactionscript.asconfigc.AIRPlatformType;

	import nextgenas.test.assert.Assert;
	import com.nextgenactionscript.asconfigc.SigningOptions;
	import com.nextgenactionscript.asconfigc.AIRTarget;

	public class AIROptionsTests
	{
		[Test]
		public function testAIRDownloadURL():void
		{
			var value:String = "http://example.com";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {}
			args[AIRPlatformType.ANDROID][AIROptions.AIR_DOWNLOAD_URL] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.AIR_DOWNLOAD_URL);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testArch():void
		{
			var value:String = "x86";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {}
			args[AIRPlatformType.ANDROID][AIROptions.ARCH] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.ARCH);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testEmbedBitcode():void
		{
			var value:Boolean = true;
			var args:Object = {};
			args[AIRPlatformType.IOS] = {}
			args[AIRPlatformType.IOS][AIROptions.EMBED_BITCODE] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.EMBED_BITCODE);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value.toString()), optionIndex + 1);
		}

		[Test]
		public function testExtdir():void
		{
			var value:Array = [
				"path/subpath1",
				"path/subpath2",
			];
			var args:Object = {};
			args[AIROptions.EXTDIR] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex1:int = result.indexOf("-" + AIROptions.EXTDIR);
			Assert.notStrictEqual(optionIndex1, -1);
			Assert.strictEqual(result.indexOf(value[0]), optionIndex1 + 1);
			var optionIndex2:int = result.indexOf("-" + AIROptions.EXTDIR, optionIndex1 + 1);
			Assert.notStrictEqual(optionIndex2, -1);
			Assert.strictEqual(result.indexOf(value[1]), optionIndex2 + 1);
		}

		[Test]
		public function testFiles():void
		{
			var file1:Object = {};
			file1[AIROptions.FILES_FILE] = "path/to/file1.png";
			file1[AIROptions.FILES_PATH] = "file1.png";
			var file2:Object = {};
			file2[AIROptions.FILES_FILE] = "path/to/file2.png";
			file2[AIROptions.FILES_PATH] = "other/file2.png";
			var value:Array = [
				file1,
				file2
			];
			var args:Object = {};
			args[AIROptions.FILES] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex1:int = result.indexOf("-e");
			Assert.notStrictEqual(optionIndex1, -1);
			Assert.strictEqual(result.indexOf(file1[AIROptions.FILES_FILE]), optionIndex1 + 1);
			Assert.strictEqual(result.indexOf(file1[AIROptions.FILES_PATH]), optionIndex1 + 2);
			var optionIndex2:int = result.indexOf("-e", optionIndex1 + 1);
			Assert.notStrictEqual(optionIndex2, -1);
			Assert.strictEqual(result.indexOf(file2[AIROptions.FILES_FILE]), optionIndex2 + 1);
			Assert.strictEqual(result.indexOf(file2[AIROptions.FILES_PATH]), optionIndex2 + 2);
		}

		[Test]
		public function testHideAneLibSymbols():void
		{
			var value:Boolean = true;
			var args:Object = {};
			args[AIRPlatformType.IOS] = {}
			args[AIRPlatformType.IOS][AIROptions.HIDE_ANE_LIB_SYMBOLS] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.HIDE_ANE_LIB_SYMBOLS);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value.toString()), optionIndex + 1);
		}

		[Test]
		public function testOutput():void
		{
			var value:String = "path/to/file.air";
			var args:Object = {};
			args[AIROptions.OUTPUT] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			//no -output, just the path without anything else
			Assert.strictEqual(result.indexOf("-" + AIROptions.OUTPUT), -1);
			Assert.notStrictEqual(result.indexOf(value.toString()), -1);
		}

		[Test]
		public function testAndroidOutput():void
		{
			var androidValue:String = "path/to/file.apk";
			var iOSValue:String = "path/to/file.ipa";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.OUTPUT] = androidValue;
			args[AIRPlatformType.IOS] = {};
			args[AIRPlatformType.IOS][AIROptions.OUTPUT] = iOSValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(androidValue), -1);
			Assert.strictEqual(result.indexOf(iOSValue), -1);
		}

		[Test]
		public function testIOSOutput():void
		{
			var androidValue:String = "path/to/file.apk";
			var iOSValue:String = "path/to/file.ipa";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.OUTPUT] = androidValue;
			args[AIRPlatformType.IOS] = {};
			args[AIRPlatformType.IOS][AIROptions.OUTPUT] = iOSValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(iOSValue), -1);
			Assert.strictEqual(result.indexOf(androidValue), -1);
		}

		[Test]
		public function testAndroidPlatformSDK():void
		{
			var iOSValue:String = "path/to/ios_sdk";
			var androidValue:String = "path/to/android_sdk";
			var args:Object = {};
			args[AIRPlatformType.IOS] = {}
			args[AIRPlatformType.IOS][AIROptions.PLATFORMSDK] = iOSValue;
			args[AIRPlatformType.ANDROID] = {}
			args[AIRPlatformType.ANDROID][AIROptions.PLATFORMSDK] = androidValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.PLATFORMSDK);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(androidValue), optionIndex + 1);
			Assert.strictEqual(result.indexOf(iOSValue), -1);
		}

		[Test]
		public function testIOSPlatformSDK():void
		{
			var iOSValue:String = "path/to/ios_sdk";
			var androidValue:String = "path/to/android_sdk";
			var args:Object = {};
			args[AIRPlatformType.IOS] = {}
			args[AIRPlatformType.IOS][AIROptions.PLATFORMSDK] = iOSValue;
			args[AIRPlatformType.ANDROID] = {}
			args[AIRPlatformType.ANDROID][AIROptions.PLATFORMSDK] = androidValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.PLATFORMSDK);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(iOSValue), optionIndex + 1);
			Assert.strictEqual(result.indexOf(androidValue), -1);
		}

		[Test]
		public function testSampler():void
		{
			var value:Boolean = true;
			var args:Object = {};
			args[AIRPlatformType.IOS] = {}
			args[AIRPlatformType.IOS][AIROptions.SAMPLER] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.SAMPLER);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value.toString()), optionIndex + 1);
		}

		[Test]
		public function testTarget():void
		{
			var value:String = AIRTarget.NATIVE;
			var args:Object = {};
			args[AIROptions.TARGET] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + AIROptions.TARGET);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value.toString()), optionIndex + 1);
		}

		[Test]
		public function testIOSTarget():void
		{
			var androidTarget:String = "apk-captive-runtime";
			var iOSTarget:String = "ipa-ad-hoc";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.TARGET] = androidTarget;
			args[AIRPlatformType.IOS] = {};
			args[AIRPlatformType.IOS][AIROptions.TARGET] = iOSTarget;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(iOSTarget), -1);
			Assert.strictEqual(result.indexOf(androidTarget), -1);
		}

		[Test]
		public function testAndroidTarget():void
		{
			var androidTarget:String = "apk-captive-runtime";
			var iOSTarget:String = "ipa-ad-hoc";
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.TARGET] = androidTarget;
			args[AIRPlatformType.IOS] = {};
			args[AIRPlatformType.IOS][AIROptions.TARGET] = iOSTarget;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(androidTarget), -1);
			Assert.strictEqual(result.indexOf(iOSTarget), -1);
		}

	//------ signing options

		[Test]
		public function testSigningOptionsAlias():void
		{
			var value:String = "AIRcert";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.ALIAS] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.ALIAS);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testSigningOptionsKeystore():void
		{
			var value:String = "path/to/keystore.p12";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.KEYSTORE] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.KEYSTORE);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testSigningOptionsProviderName():void
		{
			var value:String = "className";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.PROVIDER_NAME] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.PROVIDER_NAME);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testSigningOptionsStoretype():void
		{
			var value:String = "pkcs12";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.STORETYPE] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.STORETYPE);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testSigningOptionsTsa():void
		{
			var value:String = "none";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.TSA] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.AIR, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.TSA);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

		[Test]
		public function testSigningOptionsProvisioningProfile():void
		{
			var value:String = "path/to/file.mobileprovision";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = {};
			args[AIROptions.SIGNING_OPTIONS][SigningOptions.PROVISIONING_PROFILE] = value;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.IOS, false, "application.xml", "test.swf", args);
			var optionIndex:int = result.indexOf("-" + SigningOptions.PROVISIONING_PROFILE);
			Assert.notStrictEqual(optionIndex, -1);
			Assert.strictEqual(result.indexOf(value), optionIndex + 1);
		}

	//------ overrides

		[Test]
		public function testOutputPlatformOverride():void
		{
			var androidValue:String = "path/to/file.apk";
			var defaultValue:String = "path/to/file.air";
			var args:Object = {};
			args[AIROptions.OUTPUT] = defaultValue;
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.OUTPUT] = androidValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(androidValue), -1);
			Assert.strictEqual(result.indexOf(defaultValue), -1);
		}

		[Test]
		public function testTargetPlatformOverride():void
		{
			var androidTarget:String = "apk-captive-runtime";
			var defaultTarget:String = "bundle";
			var args:Object = {};
			args[AIROptions.TARGET] = defaultTarget;
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.TARGET] = androidTarget;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			Assert.notStrictEqual(result.indexOf(androidTarget), -1);
			Assert.strictEqual(result.indexOf(defaultTarget), -1);
		}

		[Test]
		public function testExtdirPlatformOverride():void
		{
			var androidValue:Array = [
				"path/subpath1",
				"path/subpath2",
			];
			var defaultValue:Array = [
				"path/subpath3"
			];
			var args:Object = {};
			args[AIRPlatformType.ANDROID] = {}
			args[AIRPlatformType.ANDROID][AIROptions.EXTDIR] = androidValue;
			args[AIROptions.EXTDIR] = defaultValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			var optionIndex1:int = result.indexOf("-" + AIROptions.EXTDIR);
			Assert.notStrictEqual(optionIndex1, -1);
			Assert.strictEqual(result.indexOf(androidValue[0]), optionIndex1 + 1);
			var optionIndex2:int = result.indexOf("-" + AIROptions.EXTDIR, optionIndex1 + 1);
			Assert.notStrictEqual(optionIndex2, -1);
			Assert.strictEqual(result.indexOf(androidValue[1]), optionIndex2 + 1);
		}

		[Test]
		public function testSigningOptionsPlatformOverride():void
		{
			var androidValue:Object = {};
			androidValue[SigningOptions.KEYSTORE] = "path/to/android_keystore.p12";
			androidValue[SigningOptions.STORETYPE] = "pkcs12";
			var defaultValue:Object = {};
			defaultValue[SigningOptions.KEYSTORE] = "path/to/keystore.p12";
			defaultValue[SigningOptions.STORETYPE] = "pkcs12";
			androidValue[SigningOptions.TSA] = "none";
			var args:Object = {};
			args[AIROptions.SIGNING_OPTIONS] = defaultValue;
			args[AIRPlatformType.ANDROID] = {};
			args[AIRPlatformType.ANDROID][AIROptions.SIGNING_OPTIONS] = androidValue;
			var result:Array = AIROptionsParser.parse(AIRPlatformType.ANDROID, false, "application.xml", "test.swf", args);
			var optionIndex1:int = result.indexOf("-" + SigningOptions.KEYSTORE);
			Assert.notStrictEqual(optionIndex1, -1);
			Assert.strictEqual(result.indexOf(androidValue[SigningOptions.KEYSTORE]), optionIndex1 + 1);
			var optionIndex2:int = result.indexOf("-" + SigningOptions.STORETYPE);
			Assert.notStrictEqual(optionIndex2, -1);
			Assert.strictEqual(result.indexOf(androidValue[SigningOptions.STORETYPE]), optionIndex2 + 1);
			//this one doesn't exist in the android signing options
			Assert.strictEqual(result.indexOf(defaultValue[SigningOptions.TSA]), -1);
		}
	}
}