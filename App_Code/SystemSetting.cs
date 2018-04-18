using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// SystemSetting 的摘要描述
/// </summary>

namespace Dokkan
{ 
    public class SystemSetting
    {
        public SystemSetting()
        {
            //
            // TODO: 在這裡新增建構函式邏輯
            //

          
        }

        public static bool IsRelease
        {
            get
            {
                System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
                if (0 < rootWebConfig.AppSettings.Settings.Count)
                {
                    System.Configuration.KeyValueConfigurationElement customSetting = rootWebConfig.AppSettings.Settings["Version"];
                    if (null != customSetting)
                    {
                        if (customSetting.Value == "Debug")
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    else
                        return false;
                }
                return false;
            }
        }
    }
}