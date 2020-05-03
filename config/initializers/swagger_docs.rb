
Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis({
                                        "1.0" => {
                                            # the extension used for the API
                                            :api_extension_type => :json,
                                            # the output location where your .json files are written to
                                            :api_file_path => "public/",
                                            # the URL base path to your API
                                            :base_path => "https://mighty-crag-95482.herokuapp.com:3000",
                                            # if you want to delete all .json files at each generation
                                            :clean_directory => false,
                                            # Ability to setup base controller for each api version. Api::V1::SomeController for example.
                                            :parent_controller => ActionController::API,
                                            # add custom attributes to api-docs
                                            :attributes => {
                                                :info => {
                                                    "title" => "Bowling REST API",
                                                    "description" => "This is a Ruby on Rails app that provides a REST API for Bowling games.",
                                                    "contact" => "gterra023@gmail.com"
                                                }
                                            }
                                        }
                                    })