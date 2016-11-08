# NuGet package

[![Build status](https://ci.appveyor.com/api/projects/status/kjnasckwjk6q4ssq?svg=true)](https://ci.appveyor.com/project/lekiscz/openeet)


# Work In Progress

Even if working well with playground of the EET system, this is still work in progress.
Any contribution is welcomed!


# C# implementation of core EET functionalities

Look at tests project for example how to use the main class EetRegisterRequest.

There are no other dependencies but .NET Framework (built on 4.5, I see no restriction 
to compile with any lower version - SHA256 support is required).

List of features:

* build a sale registration based on business data
* generate PKP/BKP for receipt printing
* generate valid signed SOAP message
* send the request to the playground endpoint
* receive response containing FIK


# Usage

* build and use compiled assembly
  * open & build solution dotnet\openeet-lite\openeet-lite.sln
  * use dotnet\openeet-lite\bin\Release\openeet-lite.dll in your project

* OR use the openeet-lite project directly as part of your solution

* OR use NuGet
  * add https://ci.appveyor.com/nuget/openeet-q6wo7f23nl52 as NuGet source to your NuGet configuration (either in Visual Studio GUI or in NuGet.config file)
  * add NuGet package openeet-lite from this source to your projects


## Code

```c#
// set minimal business data & certificate with key loaded from PKCS12 file
EetRegisterRequest request = new EetRequestBuilder()
{
    DicPopl = "CZ1212121218",
    IdProvoz = "1",
    IdPokl = "POKLADNA01",
    PoradCis = "1",
    DatTrzby = DateTime.Now,
    CelkTrzba = 100.0,
    Rezim = 0,
    Pkcs12 = File.ReadAllBytes("01000003.p12"),
    Pkcs12password = "eet",
}.Build();

// for receipt printing in online mode
string bkp = request.FormatBkp();
if (bkp == null) throw new ApplicationException("BKP is null");

// for receipt printing in offline mode
string pkp = request.FormatPkp();
if (pkp == null) throw new ApplicationException("PKP is null");

// the receipt can be now stored for offline processing

// try send
string requestBody = request.GenerateSoapRequest();
if (requestBody == null) throw new ApplicationException("SOAP request is null");

string response = await request.SendRequestAsync(requestBody, "https://pg.eet.cz:443/eet/services/EETServiceSOAP/v3");
// extract FIK
if (response == null) throw new ApplicationException("response is null");
if (response.IndexOf("Potvrzeni fik=", StringComparison.Ordinal) < 0) throw new ApplicationException("FIK not found in the response");

// ready to print online receipt
Console.WriteLine("OK!");
```


# Plans

* certificate management utilities - create cert request, get certificate and key ready to use (depends on including CA services in the playground)
* basic offline processing - mainly in the point of view of request structure manipulation (what remains unchanged when resending)
