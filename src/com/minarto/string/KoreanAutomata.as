package com.minarto.string
{
	public final class KoreanAutomata
	{
		/**
		 * 
		 */		
		private const firstWord:Vector.<String> = Vector.<String>(["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]);
		private const middleWord:Vector.<String> = Vector.<String>(["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]);
		private const endWord:Vector.<String> = Vector.<String>(["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]);
		
		
		/**
		 * 
		 * @param $msg
		 * @return Vector.<String>
		 * 
		 */		
		public function getAutomata($msg:String):Vector.<String>
		{
			var returnWord:Vector.<String> = new Vector.<String>();
			
			var i:uint;
			const length:uint = $msg.length;
			const charCodeAt:Function = $msg.charCodeAt;
			const charAt:Function = $msg.charAt;
			const push:Function = returnWord.push;
			var charCode:uint;
			while(i < length)
			{
				charCode = charCodeAt(i);
				if(44032 > charCode || charCode > 55023)
				{
					push(charAt(i));
				}
				else
				{
					charCode -= 44032;
					push(firstWord[uint(charCode / 588)]);	//	초성
					
					charCode = charCode % 588;
					push(middleWord[uint(charCode / 28)]);	//	중성
					
					charCode = charCode % 28;
					switch(charCode)
					{
						case 2 :
							push("ㄱ", "ㄱ");
							break;
						case 3 :
							push("ㄱ", "ㅅ");
							break;
						case 5 :
							push("ㄴ", "ㅈ");
							break;
						case 6 :
							push("ㄴ", "ㅎ");
							break;
						case 9 :
							push("ㄹ", "ㄱ");
							break;
						case 10 :
							push("ㄹ", "ㅁ");
							break;
						case 11 :
							push("ㄹ", "ㅂ");
							break;
						case 12 :
							push("ㄹ", "ㅅ");
							break;
						case 13 :
							push("ㄹ", "ㅌ");
							break;
						case 14 :
							push("ㄹ", "ㅍ");
							break;
						case 15 :
							push("ㄹ", "ㅎ");
							break;
						case 18 :
							push("ㅂ", "ㅅ");
							break;
						case 20 :
							push("ㅅ", "ㅅ");
							break;
						case 23 :
							push("ㅈ", "ㅈ");
							break;
						default :
							if(charCode)	push(endWord[charCode]);
					}
				}
				
				++ i;
			}
			
			returnWord.fixed = true;
			
			return	returnWord;
		}
	}
}