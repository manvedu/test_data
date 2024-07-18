# Welcome to File Processor Project
Hi! 

This project aims to demonstrate how to process files under certain circumstances, using some dry gems thinking it in a functional way.
To use the service, we assume there is a human who knows the structure of the data.

We have some constraints, such as the size of the file and the fact that the we assume columns are separated by blank spaces and encoded in UTF-8.
Some improvements need to be considered and thought about. For instance, what happens when the file size exceeds the limit or when the data format changes? Addressing these scenarios will ensure the robustness and flexibility of the system.
We can add some refactor to have more specialized classes.
This service returns all possible values that match the condition.

# Installation
- Clone project from **git@github.com:manvedu/test_data.git**
- Install bundler `gem install bundler`
- Install gems ` bundle`

# Usage

```
  service = ComparisionProcessor::GetValue.new
  input = {   
    file_path: '',
    header_clue: '<pre>',
    footer_clue: '</pre>',
    select_operation: 'max',
    minuend_index: 1,
    subtrahend_index: 2,
    column_to_return_index: 0,
    blank_spaces_between_footer_and_last_row: 2,
    blank_spaces_between_header_and_first_row: 4
  }   
  result = service.call(input)
```

Input parameters description
<table>
  <tr>
    <th>Param name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Required</th>
    <th>Restrictions</th>
  </tr>
  <tr>
    <td>file_path</td>
    <td>Path to the file, take into account it's understand from the root project.</td>
    <td>String</td>
    <td>true</td>
    <td></td>
  </tr>
  <tr>
    <td>header_clue</td>
    <td>word which helps to understand what the table headers are</td>
    <td>String</td>
    <td>true</td>
    <td></td>
  </tr>
  <tr>
    <td>footer_clue</td>
    <td>word which helps to understand what the table footer or last row are</td>
    <td>String</td>
    <td>true</td>
    <td></td>
  </tr>
  <tr>
    <td>select_operation</td>
    <td>we can identify if we want to have a max or min value</td>
    <td>String</td>
    <td>true</td>
    <td>The unique available options by the moment are max and min. We can perhaps change it in future instead of having a word we can just pass the block of code we want to evaluate</td>   
  </tr>
  <tr>
    <td>minuend_index</td>
    <td>In this service we evaluate the difference, so is the index of the minuend field.</td>
    <td>String</td>
    <td>true</td>
    <td></td>   
  </tr>
  <tr>
    <td>subtrahend_index</td>
    <td>In this service we evaluate the difference, so is the index of the subtrahend field.</td>
    <td>String</td>
    <td>true</td>
    <td></td>   
  </tr>
  <tr>
    <td>column_to_return_index</td>
    <td>This is the index of the column we want to return at the end.</td>
    <td>String</td>
    <td>true</td>
    <td></td>   
  </tr>
  <tr>
    <td>blank_spaces_between_footer_and_last_row</td>
    <td>This is the number of rows we have between the footer and the last row of data</td>
    <td>String</td>
    <td>true</td>
    <td></td>   
  </tr>
  <tr>
    <td>blank_spaces_between_header_and_first_row</td>
    <td>This is the number of rows we have between the header of the document and the first row of data</td>
    <td>String</td>
    <td>true</td>
    <td></td>   
  </tr>
</table>

# Run tests

```
bundle exec rspec spec/
```

---
**NOTE**

There is a script file that was the first attempt to achieve this requirement, and it is included in this repository to demonstrate the process.

---
