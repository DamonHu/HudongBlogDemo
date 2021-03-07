/****************************************************************************
Copyright (c) 2012-2013 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
#include "ProtocolDynamic.h"
#include "PluginJniHelper.h"
#include <android/log.h>
#include "PluginUtils.h"
#include "PluginJavaData.h"

namespace cocos2d { namespace plugin {

extern "C" {
	JNIEXPORT void JNICALL Java_org_cocos2dx_plugin_SocialWrapper_nativeOnShareResults(JNIEnv*  env, jobject thiz, jstring className, jint ret, jstring msg)
	{
		std::string strMsg = PluginJniHelper::jstring2string(msg);
		std::string strClassName = PluginJniHelper::jstring2string(className);
		PluginProtocol* pPlugin = PluginUtils::getPluginPtr(strClassName);
		PluginUtils::outputLog("ProtocolDynamic", "nativeOnShareResult(), Get plugin ptr : %p", pPlugin);
		if (pPlugin != NULL)
		{
			PluginUtils::outputLog("ProtocolDynamic", "nativeOnShareResult(), Get plugin name : %s", pPlugin->getPluginName());
			ProtocolDynamic* pSocial = dynamic_cast<ProtocolDynamic*>(pPlugin);
			if (pSocial != NULL)
			{
				pSocial->onShareResults((ShareResultCode1) ret, strMsg.c_str());
			}
		}
	}
}

ProtocolDynamic::ProtocolDynamic()
: m_pListener(NULL)
{
}

ProtocolDynamic::~ProtocolDynamic()
{
}
void ProtocolDynamic::login()
{
    PluginUtils::callJavaFunctionWithName(this, "login");
}
void ProtocolDynamic::logout()
{
        
}
void ProtocolDynamic::configDeveloperInfo(TSocialDeveloperInfo devInfo)
{
    if (devInfo.empty())
    {
        PluginUtils::outputLog("ProtocolDynamic", "The developer info is empty!");
        return;
    }
    else
    {
        PluginJavaData* pData = PluginUtils::getPluginJavaData(this);
    	PluginJniMethodInfo t;
        if (PluginJniHelper::getMethodInfo(t
    		, pData->jclassName.c_str()
    		, "configDeveloperInfo"
    		, "(Ljava/util/Hashtable;)V"))
    	{
        	// generate the hashtable from map
        	jobject obj_Map = PluginUtils::createJavaMapObject(&devInfo);

            // invoke java method
            t.env->CallVoidMethod(pData->jobj, t.methodID, obj_Map);
            t.env->DeleteLocalRef(obj_Map);
            t.env->DeleteLocalRef(t.classID);
        }
    }
}

void ProtocolDynamic::share(TShareInfo info)
{
    if (info.empty())
    {
        if (NULL != m_pListener)
        {
            onShareResults(kShareFail1, "Share info error");
        }
        PluginUtils::outputLog("ProtocolDynamic", "The Share info is empty!");
        return;
    }
    else
    {
        PluginJavaData* pData = PluginUtils::getPluginJavaData(this);
		PluginJniMethodInfo t;
		if (PluginJniHelper::getMethodInfo(t
			, pData->jclassName.c_str()
			, "share"
			, "(Ljava/util/Hashtable;)V"))
		{
			// generate the hashtable from map
			jobject obj_Map = PluginUtils::createJavaMapObject(&info);

			// invoke java method
			t.env->CallVoidMethod(pData->jobj, t.methodID, obj_Map);
			t.env->DeleteLocalRef(obj_Map);
			t.env->DeleteLocalRef(t.classID);
		}
    }
}

void ProtocolDynamic::setResultListener(ShareResultListener1* pListener)
{
	m_pListener = pListener;
}

void ProtocolDynamic::onShareResults(ShareResultCode1 ret, const char* msg)
{
    if (m_pListener)
    {
    	m_pListener->onShareResults(ret, msg);
    }
    else
    {
        PluginUtils::outputLog("ProtocolDynamic", "Result listener is null!");
    }
    PluginUtils::outputLog("ProtocolDynamic", "Share result is : %d(%s)", (int) ret, msg);
}

}} // namespace cocos2d { namespace plugin {
