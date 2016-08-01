package
{
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.Style;
	import com.bit101.components.TextArea;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0x333333, frameRate = 30)]
	public class Main extends Sprite 
	{
		private var _unClipedCanvas:Sprite = new Sprite();
		private var _clipedCanvas:Sprite = new Sprite();
		private var _textArea:TextArea;
		private var _sizeNS:NumericStepper;
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = "noScale";
			stage.align = "TL";
			
			Style.embedFonts = false;
			Style.fontName = "_等幅";
			Style.fontSize = 13; //13ポイントが読みやすい
			Style.setStyle(Style.DARK);
			
			_textArea = new TextArea(this, 8, 8, "金主○");
			_textArea.width = stage.stageWidth - 16;
			_textArea.height = 40;
			_textArea.addEventListener(Event.CHANGE, change);
			
			_sizeNS = new NumericStepper(this, 8, 55, change);
			_sizeNS.value = 154;
			
			
			_unClipedCanvas.y = 100;
			addChild(_unClipedCanvas);
			new Label(this, 8, 240, "TextFieldをBitmapDataにdrawしたもの");
			
			_clipedCanvas.y = 290;
			addChild(_clipedCanvas);
			new Label(this, 8, 430, "textに改行を加え、draw後に描画エリアを判別して切り抜いたもの");
			
			onChage();
		}
		
		private function change(e:Event):void 
		{
			onChage();
		}
		
		private function onChage():void {
			_unClipedCanvas.removeChildren();
			_clipedCanvas.removeChildren();
			
			_unClipedCanvas.addChild(new Bitmap(TextManager.getInstance().getBitmapDataFromText(_textArea.text, _sizeNS.value, false)));
			_clipedCanvas.addChild(new Bitmap(TextManager.getInstance().getBitmapDataFromText(_textArea.text, _sizeNS.value, true)));
			
		}
		
		
	}
	
}