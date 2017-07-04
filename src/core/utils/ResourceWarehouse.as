package core.utils {
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;

   public class ResourceWarehouse {

      private var _wh:Vector.<DisplayObject> = new <DisplayObject>[];

      private static var _instance:ResourceWarehouse;

      public static function  getInstance():ResourceWarehouse
      {
         if (_instance==null)
         {
            _instance= new ResourceWarehouse();
         }
         return _instance as ResourceWarehouse;
      }

      public function addAsset(asset:DisplayObject):void
      {
         _wh.push(asset);
      }

      public function getAsset(assetName:String):DisplayObject
      {
         for each(var loader:Loader in _wh)
            for each(var asset:DisplayObject in loader.content){
               if (asset.name == assetName)
               {
                  return asset;
                  break;
               }
            }
         return null;
      }

      public function getAssetClass(assetClassName:String):Class
      {
         var AssetClass:Class;
         for each(var loader:Loader in _wh)
            if (loader.contentLoaderInfo.applicationDomain.hasDefinition(assetClassName))
            {
               AssetClass = loader.contentLoaderInfo.applicationDomain.getDefinition(assetClassName) as Class;
               break;
            }
         return AssetClass;
      }
   }
}


