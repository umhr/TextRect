package 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class TextManager 
	{
		private static var _instance:TextManager;
		public function TextManager(block:Block){init();};
		public static function getInstance():TextManager{
			if ( _instance == null ) {_instance = new TextManager(new Block());};
			return _instance;
		}
		
		
		private function init():void
		{
			
		}
		
		public function getBitmapDataFromText(text:String, size:int, isClip:Boolean):BitmapData {
			if (isClip) {
				text = "\n" + text;
			}
			var result:BitmapData = new BitmapData(1000, 500, true, 0x00000000);
			result.draw(getTextField(text, size));
			if (isClip) {
				result = clipRect(result);
			}
			return result;
		}
		
		private function getTextField(str:String, size:int):TextField {
			var result:TextField = new TextField();
			result.defaultTextFormat = new TextFormat(new NotoSansJapaneseMedium_df3().fontName, size, 0xFFFFFF);
			result.embedFonts = true;
			result.text = str;
			result.width = result.textWidth * 1.2;
			result.height = result.textHeight * 1.2;
			//result.border = true;
			//result.borderColor = 0x0000FF;
			return result;
		}
		
		private function clipRect(target:BitmapData):BitmapData {
			var rect:Rectangle = target.getColorBoundsRect(0xFFFFFFFF, 0x00000000, false);
			if (rect.bottomRight.length == 0) {
				rect.width = rect.height = 1;
			}
			
			var result:BitmapData = new BitmapData(rect.width, rect.height, true, 0x00000000);
			result.draw(target, new Matrix(1, 0, 0, 1, -rect.x, -rect.y));
			return result;
		}
		
		
		
	}
	
}
class Block { };