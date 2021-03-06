/*
Copyright 2016-2017 Bowler Hat LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package com.nextgenactionscript.utils
{
	/**
	 * Utilities for finding and running executables from an ActionScript SDK.
	 */
	public class ActionScriptSDKUtils
	{
		/**
		 * @private
		 */
		private static const MXMLC:String = "mxmlc";

		/**
		 * Determines if a directory contains a valid Flex SDK.
		 */
		public static function isValidSDK(absolutePath:String):Boolean
		{
			if(!absolutePath)
			{
				return false;
			}
			var sdkDescriptionPath:String = path.join(absolutePath, "flex-sdk-description.xml");
			if(!fs.existsSync(sdkDescriptionPath))
			{
				sdkDescriptionPath = path.join(absolutePath, "air-sdk-description.xml");
			}
			if(!fs.existsSync(sdkDescriptionPath) || fs.statSync(sdkDescriptionPath).isDirectory())
			{
				return false;
			}
			var mxmlcPath:String = path.join(absolutePath, "bin", MXMLC);
			if(!fs.existsSync(mxmlcPath) || fs.statSync(mxmlcPath).isDirectory())
			{
				return false;
			}
			return true;
		}

		/**
		 * Attempts to find a valid Flex SDK by searching for the FLEX_HOME
		 * environment variable and testing the PATH environment variable.
		 */
		public static function findSDK():String
		{
			var sdkPath:String = null;

			if("FLEX_HOME" in process.env)
			{
				sdkPath = process.env["FLEX_HOME"];
				if(isValidSDK(sdkPath))
				{
					return sdkPath;
				}
			}

			if("PATH" in process.env)
			{
				var paths:Array = process.env["PATH"].split(path.delimiter);
				var pathCount:int = paths.length;
				for(var i:int = 0; i < pathCount; i++)
				{
					var currentPath:String = paths[i];
					var mxmlcPath:String = path.join(currentPath, MXMLC);
					if(fs.existsSync(mxmlcPath))
					{
						mxmlcPath = fs.realpathSync(mxmlcPath);
						sdkPath = path.join(path.dirname(mxmlcPath), "..", "..");
						if(isValidSDK(sdkPath))
						{
							return sdkPath;
						}
					}
				}
			}
			return null;
		}
	}
}