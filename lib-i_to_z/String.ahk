String_Fill(char, count)
{
	result =
	Loop, %count%
	{
		result := result . char
	}
	return result
}

String_CopyFormat(pattern, string)
{
	result := string
	if String_IsUpperCase(pattern)
	{
		;~ OutputDebug, String_CopyFormat: %pattern% is upper
		StringUpper, result, string
	}
	else if (String_IsSentenceCase(pattern))
	{
		;~ OutputDebug, String_CopyFormat: %pattern% is sentence
		result := String_ToSentenceCase(string)
	}
	; Do not forget to comment out the word 'else' when commenting out OutputDebug
	;~ else
		;~ OutputDebug, String_CopyFormat: %pattern% is lower/mixed case.
	
	;~ OutputDebug, String_CopyFormat: result = %result%
	return result
}

String_IsUpperCase(string)
{
	FoundPos := RegExMatch(string, "P)^\p{Lu}+$", Matches)
	if(FoundPos = 1)
		return true
	else
	{
		;~ OutputDebug, RegExMatch result = %FoundPos%; ErrorLevel = %ErrorLevel%
		return false
	}
}

String_IsSentenceCase(string)
{
	FoundPos := RegExMatch(string, "P)^\p{Lu}\p{Ll}+$", Matches)
	if(FoundPos = 1)
		return true
	else
	{
		;~ OutputDebug, RegExMatch result = %FoundPos%; ErrorLevel = %ErrorLevel%
		return false
	}
}

String_ToSentenceCase(string)
{
	;~ OutputDebug, String_ToSentenceCase: Converting '%string%'
	StringLeft, Head, string, 1
	;~ OutputDebug, String_ToSentenceCase: Head = '%Head%'
	StringMid, Tail, string, 2
	;~ OutputDebug, String_ToSentenceCase: Tail = '%Tail%'
	StringUpper, Head, Head
	;~ OutputDebug, String_ToSentenceCase: Converted Head = '%Head%'
	result = %Head%%Tail%
	;~ OutputDebug, String_ToSentenceCase: result = '%result%'
	return result
}

String_StripTags(s)
{
	while(RegExMatch(s, "O)<\w+.+>", match))
	{
		StringReplace, s, s, % match.Value(0), all
	}
	return s
}

String_StartsWith(haystack, needle)
{
  return InStr(haystack, needle) = 1
}

String_IsEqual(haystack, needle, caseSensitive=true)
{
  escapeChars = \.*?+[{|()^$
  Loop, parse, escapeChars
  {
    StringReplace, needle, needle, %A_LoopField%, \%A_LoopField%
  }
  rx = ^%needle%$
  if(!caseSensitive)
    rx = i)%rx%
  
  result := RegExMatch(haystack, rx)
;   OutputDebug %result% := RegExMatch(%haystack%, %rx%)
  return result
}