using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

// No icon services needed - using embedded source-generated components

await builder.Build().RunAsync();
