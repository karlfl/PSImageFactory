using System;
namespace PSImageFactory {
        public class ImageFactoryVm
        {
                public string FriendlyName{ get; set; }
                public string IsoFile{ get; set; }
                public string ProductKey{ get; set; }
                public string SkuEdition{ get; set; }
                public bool Desktop { get; set; }
                public bool Is32bit { get; set; }
                public bool Generation2 { get; set; }
                public bool GenericSysprep { get; set; }
                public string ImageFile { get; set; }
                public DateTime Created { get; set; }
                public DateTime LastChecked{ get; set; }
                public DateTime LastSysPrep{ get; set; }
        }
}