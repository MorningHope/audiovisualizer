@echo off
powershell -command "(New-Object System.Net.WebClient).DownloadFile('http://dist.nuget.org/win-x86-commandline/latest/nuget.exe', 'nuget.exe')" && (
nuget.exe restore AudioVisualizer.sln && (
msbuild AudioVisualizer.sln /t:build /p:Configuration=CIBUILD;Platform=x86 && (
	msbuild AudioVisualizer.sln /t:build /p:Configuration=CIBUILD;Platform=x64 && (
		Tools\nuget.exe pack AudioAnalyzer.nuspec -o .\package -Version %1 && (
			echo "Package created"
		) || ( 
			echo "x64 build failed"
		)
	)

) || (
	echo "x86 build failed"
)
) || (
	echo "failed to restore packages"
)
) || (
	echo "failed to get nuget.exe"
)