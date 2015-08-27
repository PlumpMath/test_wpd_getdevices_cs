# test_wpd_getdevices_cs
test application. wpd and mtp on C#, apply tlbimp Interop fixture GetDevices and others

## 1st build

Visual Studio generate 'Interop.PortableDeviceApiLib.dll' by tlbimp.
But 'Interop.PortableDeviceApiLib.dll' include mismatch COM method

## 2nd build

_gen.bat apply to 'Interop.PortableDeviceApiLib.dll'
* PortableDeviceApiLib.IPortableDeviceManager.GetDevices
* PortableDeviceApiLib.PortableDeviceManagerClass.GetDevices
* PortableDeviceApiLib.IPortableDeviceManager.GetDeviceFriendlyName
* PortableDeviceApiLib.PortableDeviceManagerClass.GetDeviceFriendlyName
* PortableDeviceApiLib.IPortableDeviceManager.GetDeviceDescription
* PortableDeviceApiLib.PortableDeviceManagerClass.GetDeviceDescription
* PortableDeviceApiLib.IPortableDeviceManager.GetDeviceManufacturer
* PortableDeviceApiLib.PortableDeviceManagerClass.GetDeviceManufacturer

# reference

* http://blogs.msdn.com/b/dimeby8/archive/2006/12/05/enumerating-wpd-devices-in-c.aspx
* http://www.andrewt.com/blog/post/2013/06/15/Fun-with-MTP-in-C.aspx
