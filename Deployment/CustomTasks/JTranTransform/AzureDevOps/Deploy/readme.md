# JTranTransform

This Azure DevOps task transforms a json file (or multiple files) using the jtran language. For a complete JTran language reference go [here](https://github.com/JTranOrg/JTran/blob/master/docs/reference.md).

#### Example
```
     - task: JTranTransform@1.0.2
       inputs:
         InputSourcePath:            $(Build.SourcesDirectory)/Samples/Deployment/AzureDevOps/blanksource.json
         TransformPath:              $(Build.SourcesDirectory)/Samples/Deployment/AzureDevOps/Config.jtran
         OutputDestinationPath:      $(Build.SourcesDirectory)/Samples/Deployment/AzureDevOps/output.json
         TransformParameters:        '-environment dev -Phrase "hello"'
```

## Parameters

#### InputSourcePath

The source json file. Multiple files can be specified using wildcards. Each source file will be transformed using the transform provided.

#### TransformPath

Path to the jtran file

#### OutputDestinationPath

Path where to write the result of the transform

#### IncludePath

An optional path to include files. See the language reference for more information.

#### DocumentPath

An optional path to document files. When this is used the document source name is "all". See the language reference for more information.

#### MultipleOutput

An optional indication on whether to output multiple files.

#### TransformParameters

An optional list of parameters to pass to the transform. The name of parameters must be preceded by a hypen followed by the value. Values may be double quoted (necessary when they contain a space).

#### ArgumentsProviderPath

An optional path to a dll that contains arguments int the transform.

#### ArgumentsClass

When <b>ArgumentsProviderPath</b> is provided this parameter is required to specify a dictionary class with a list of arguments. Must be in the format <namespace.class_name>. Class must be derived from IDictionary<string, object> and constructor must have no parameters.
