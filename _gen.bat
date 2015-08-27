rem 
rem  The MIT License
rem 
rem  Copyright 2015 Kiyofumi Kondoh
rem 
rem  Permission is hereby granted, free of charge, to any person obtaining a copy
rem  of this software and associated documentation files (the "Software"), to deal
rem  in the Software without restriction, including without limitation the rights
rem  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
rem  copies of the Software, and to permit persons to whom the Software is
rem  furnished to do so, subject to the following conditions:
rem 
rem  The above copyright notice and this permission notice shall be included in
rem  all copies or substantial portions of the Software.
rem 
rem  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
rem  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
rem  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
rem  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
rem  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
rem  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
rem  THE SOFTWARE.



rem http://blogs.msdn.com/b/dimeby8/archive/2006/12/05/enumerating-wpd-devices-in-c.aspx
rem http://www.andrewt.com/blog/post/2013/06/15/Fun-with-MTP-in-C.aspx

if x"%1" == x"" exit /b
if x"%2" == x"" exit /b
if NOT EXIST "%~dp0obj\%2\Interop.PortableDeviceApiLib.dll" GOTO clean
if EXIST "%~dp0obj\%2\Interop.PortableDeviceApiLib.il" exit /b

setlocal ENABLEDELAYEDEXPANSION

rem set to minimum path
set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem

if x"%1" == x"vs2008" call "%VS90COMNTOOLS%vsvars32.bat"
if x"%1" == x"vs2010" call "%VS100COMNTOOLS%vsvars32.bat"
if x"%1" == x"vs2012" call "%VS110COMNTOOLS%vsvars32.bat"
if x"%1" == x"vs2013" call "%VS120COMNTOOLS%vsvars32.bat"

rem set
rem tlbimp C:\Windows\System32\PortableDeviceApi.dll /namespace:PortableDeviceApiLib /machine:Agnostic /out:%~dp0obj\%2\Interop.PortableDeviceApiLib.dll /sysarray /transform:DispRet
rem TlbImp C:\Windows\system32\PortableDeviceApi.dll /namespace:PortableDeviceApiLib /machine:Agnostic /out:obj\Debug\Interop.PortableDeviceApiLib.dll /sysarray /transform:DispRet /reference:C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.dll /reference:C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.dll 

ildasm %~dp0obj\%2\Interop.PortableDeviceApiLib.dll /out=%~dp0obj\%2\Interop.PortableDeviceApiLib.ildasm
if ERRORLEVEL 1 (
  del %~dp0obj\%2\Interop.PortableDeviceApiLib.ildasm
  exit /b %ERRORLEVEL%
)

type nul > %~dp0obj\%2\Interop.PortableDeviceApiLib.il
for /f "delims=" %%a in (%~dp0obj\%2\Interop.PortableDeviceApiLib.ildasm) do (
  set line=%%a
  set line=!line:GetDevices^([in][out] string^&  marshal^( lpwstr^) pPnPDeviceIDs,=GetDevices^([in][out] string[] marshal^( lpwstr[]^) pPnPDeviceIDs,!

  set line=!line:[in][out] uint16^& pDeviceFriendlyName,=[in][out] uint16[] marshal^( uint16[]^) pDeviceFriendlyName,!
  set line=!line:[in][out] uint16^& pDeviceDescription,=[in][out] uint16[] marshal^( uint16[]^) pDeviceDescription,!
  set line=!line:[in][out] uint16^& pDeviceManufacturer,=[in][out] uint16[] marshal^( uint16[]^) pDeviceManufacturer,!
  echo !line! >> %~dp0obj\%2\Interop.PortableDeviceApiLib.il
)

ilasm %~dp0obj\%2\Interop.PortableDeviceApiLib.il /dll /output=%~dp0obj\%2\Interop.PortableDeviceApiLib.dll
if ERRORLEVEL 1 (
  del %~dp0obj\%2\Interop.PortableDeviceApiLib.il
  del %~dp0obj\%2\Interop.PortableDeviceApiLib.dll
  exit /b %ERRORLEVEL%
)

goto end

:clean
del %~dp0obj\%2\Interop.PortableDeviceApiLib.*

:end
exit /b
