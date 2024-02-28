{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_size = 2;
        indent_style = "space";
        tab_width = 2;
      };
      "*.{cs,vb}" = {
        # Doesnt need mark class members as static
        "dotnet_diagnostic.CA1822.severity" = "none";

        # Allow public accessors to class fields
        "dotnet_diagnostic.CA1051.severity" = "none";

        # Doesnt specify IFormatProvider
        "dotnet_diagnostic.CA1305.severity" = "none";

        # Remove expression is never used
        "dotnet_diagnostic.IDE0058.severity" = "none";

        # Doesnt need to use ordinal string comparison
        "dotnet_diagnostic.CA1309.severity" = "none";
      };
      "*.cs" = {
        csharp_space_after_cast = true;

        # namespace Name; instead of namespace Name { classes... }
        csharp_style_namespace_declarations = "file_scoped";

        # Use var instead of explicit type
        csharp_style_var_for_built_in_types	= true;
        csharp_style_var_when_type_is_apparent = true;
        csharp_style_var_elsewhere = true;

        # Expression bodies
        csharp_style_expression_bodied_constructors = "when_on_single_line";
        csharp_style_expression_bodied_methods = "when_on_single_line";
        csharp_style_expression_bodied_operators = "when_on_single_line";
        csharp_style_expression_bodied_properties = "when_on_single_line";

        # Disable forces to if braces {}
        csharp_prefer_braces = "when_multiline";
      };
    };
  };
}
