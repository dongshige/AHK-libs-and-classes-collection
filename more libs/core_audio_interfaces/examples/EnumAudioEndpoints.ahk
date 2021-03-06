#Include ..\header.ahk
; -------------------------------------------------------------------------------


; EnumAudioEndpoints
_IMMDeviceEnumerator := new IMMDeviceEnumerator
_IMMDeviceEnumerator.EnumAudioEndpoints(0, 0xF, _IMMDeviceCollection)    ; 0xF=ALL
_IMMDeviceEnumerator := ''

; Get Devices Name
_IMMDeviceCollection.GetCount(Count)
Loop (Count)
{
    _IMMDeviceCollection.Item(A_Index-1, _IMMDevice)
    _IMMDevice.GetState(State)
    _IMMDevice.OpenPropertyStore(0, _IPropertyStore)
    _IMMDevice := ''

    _IPropertyStore.GetValue(_IPropertyStore.PROPERTYKEY('{A45C254E-DF1C-4EFD-8020-67D146A850E0}', 14, PROPERTYKEY), PROPVARIANT)
    List .= _IPropertyStore.GetDeviceName(&PROPVARIANT) . '  [' . State . ']`n'
    _IPropertyStore := ''
}
_IMMDeviceCollection := ''

MsgBox(List)
ExitApp
