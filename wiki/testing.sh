# Test all

bin/rails t
bin/rails test
bin/rails test --verbose

# Test specific folder

bin/rails test test/integration/v1/public/*

# Test specific file

bin/rails test test/integration/v1/public/products_integration_test.rb

# Test specific test (add line number)

bin/rails test test/integration/v1/public/products_integration_test.rb:22
