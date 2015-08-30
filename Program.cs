/*
 * The MIT License
 *
 * Copyright 2015 Kiyofumi Kondoh
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// http://blogs.msdn.com/b/dimeby8/archive/2006/12/05/enumerating-wpd-devices-in-c.aspx
// http://www.andrewt.com/blog/post/2013/06/15/Fun-with-MTP-in-C.aspx

using System;
using System.Collections.Generic;

namespace test_wpd_getdevices_cs
{
    class Program
    {
        static void Main(string[] args)
        {
            PortableDeviceApiLib.PortableDeviceManager devMgr =
                new PortableDeviceApiLib.PortableDeviceManager();

            for (uint loopCount = 0; loopCount < 10000; ++loopCount)
            {
                devMgr.RefreshDeviceList();

                string[] deviceIDarray = null;
                uint nDeviceCount = 0;

                devMgr.GetDevices(null, ref nDeviceCount);
                //Console.WriteLine("nDeviceCount={0}", nDeviceCount);
                if (0 < nDeviceCount)
                {
                    deviceIDarray = new string[nDeviceCount];
                    devMgr.GetDevices(deviceIDarray, ref nDeviceCount);
                }
                if (null != deviceIDarray)
                {
                    foreach( string deviceId in deviceIDarray)
                    {
                        {
                            uint buffSize = 0;
                            devMgr.GetDeviceFriendlyName(deviceId, null, ref buffSize);
                            if (0 < buffSize)
                            {
                                ushort[] buff = new ushort[buffSize];
                                devMgr.GetDeviceFriendlyName(deviceId, buff, ref buffSize);
                                byte[] bytes = new byte[buff.Length * sizeof(ushort)];
                                Buffer.BlockCopy(buff, 0, bytes, 0, bytes.Length);
                                string str = System.Text.Encoding.Unicode.GetString(bytes);
                                //Console.WriteLine(str);
                            }
                        }
                        {
                            uint buffSize = 0;
                            devMgr.GetDeviceManufacturer(deviceId, null, ref buffSize);
                            if (0 < buffSize)
                            {
                                ushort[] buff = new ushort[buffSize];
                                devMgr.GetDeviceManufacturer(deviceId, buff, ref buffSize);
                                byte[] bytes = new byte[buff.Length * sizeof(ushort)];
                                Buffer.BlockCopy(buff, 0, bytes, 0, bytes.Length);
                                string str = System.Text.Encoding.Unicode.GetString(bytes);
                                //Console.WriteLine(str);
                            }
                        }
                        {
                            uint buffSize = 0;
                            devMgr.GetDeviceDescription(deviceId, null, ref buffSize);
                            if (0 < buffSize)
                            {
                                ushort[] buff = new ushort[buffSize];
                                devMgr.GetDeviceDescription(deviceId, buff, ref buffSize);
                                byte[] bytes = new byte[buff.Length * sizeof(ushort)];
                                Buffer.BlockCopy(buff, 0, bytes, 0, bytes.Length);
                                string str = System.Text.Encoding.Unicode.GetString(bytes);
                                //Console.WriteLine(str);
                            }
                        }
                    }
                    deviceIDarray = null;
                }
                //System.Threading.Thread.Sleep(1 * 100);
            }

        }
    }
}
