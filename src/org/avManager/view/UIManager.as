package org.avManager.view
{
	import flash.display.DisplayObject;
	
	import org.avManager.view.about.About;
	import org.libra.flex.utils.PopUpUtil;

	public final class UIManager
	{
		private static var _instance:UIManager;
		
		private var _about:About;
		
		private var _uiRoot:DisplayObject;
		
		public function UIManager(t:T)
		{
			
		}
		
		public function init(uiRoot:DisplayObject):void{
			this._uiRoot = uiRoot;
		}
		
		public function showAbout():void{
			if(!_about) _about = new About();
			PopUpUtil.instance.addPopUp(this._about, this._uiRoot, true, 1);
		}
		
		public static function get instance():UIManager{
			if(!_instance) _instance = new UIManager(new T());
			return _instance
		}
	}
}

final class T{};