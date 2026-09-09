{  
  # Required by the PHPCS Extension
  PHP = {
    language_servers = [
      "phpcs"
      "!phpactor"
    ];
  };

  # This section is to add the Tailwind LSP on blade.php files because by deafult it is not enabled
  Blade = {
    language_servers = [
      "laravel-lsp"
      "tailwindcss-language-server"
      "..." # Keep the Zed defaults available too
    ];
  };
}
