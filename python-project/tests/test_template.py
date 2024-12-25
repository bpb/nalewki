from {{project_name}}.template import template_function


def test_template():
    assert (
        template_function("{{author_name}}", "{{project_name}}")
        == "Hello, {{author_name}}! Welcome to {{project_name}}!"
    )
