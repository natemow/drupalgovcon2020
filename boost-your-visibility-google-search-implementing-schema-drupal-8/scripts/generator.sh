#!/bin/bash

ACTION=$1;
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && cd ../ && pwd)";

# Generate a new module.
  function generate_module() {

    read -p "Enter the module machine name (e.g. schema_splash_mountain): " ARG_MODULE_NAME;
    read -p "Enter the snake_case identifier (e.g. splash_mountain): " ARG_WORD_UNDERSCORED;
    read -p "Enter the UpperCamel identifier (e.g. SplashMountain): " ARG_WORD_UPPERCAMEL;

    # Copy example module.
    cp -r ./scripts/schema_medical_example ./$ARG_MODULE_NAME;
    cd ./$ARG_MODULE_NAME;

    # Replace in files.
    find ./ -type f -exec sed -i -e "s/medical_example/$ARG_WORD_UNDERSCORED/g; s/MedicalExample/$ARG_WORD_UPPERCAMEL/g;" {} \;

    # Rename files.
    mv schema_medical_example.info.yml $ARG_MODULE_NAME".info.yml";
    mv schema_medical_example.module $ARG_MODULE_NAME".module";
    mv config/schema/schema_medical_example.metatag_tag.schema.yml "config/schema/"$ARG_MODULE_NAME".metatag_tag.schema.yml";
    mv src/Plugin/metatag/Group/SchemaMedicalExample.php "src/Plugin/metatag/Group/Schema"$ARG_WORD_UPPERCAMEL".php";
    mv src/Plugin/metatag/Tag/SchemaMedicalExampleType.php "src/Plugin/metatag/Tag/Schema"$ARG_WORD_UPPERCAMEL"Type.php";

  }

# Generate a new module property.
  function generate_property() {

    local ARG_MODULE_NAME=$1;
    local ARG_PROPERTY_UNDERSCORED=$2;
    local ARG_PROPERTY_LOWERCAMEL=$3;
    local ARG_PROPERTY_CLASS_NAME=$4;

    local skeleton_config=$(cat <<'CONFIG'
metatag.metatag_tag.MODULE_NAME_PROPERTY_UNDERSCORED:
  type: text
  label: 'PROPERTY_LOWERCAMEL'
CONFIG
);
    local skeleton_code=$(cat <<'CODE'
<?php

namespace Drupal\MODULE_NAME\Plugin\metatag\Tag;

use Drupal\schema_metatag\Plugin\metatag\Tag\SchemaNameBase;

/**
 * Provides a plugin for the 'PROPERTY_LOWERCAMEL' meta tag.
 *
 * @MetatagTag(
 *   id = "MODULE_NAME_PROPERTY_UNDERSCORED",
 *   label = @Translation("PROPERTY_LOWERCAMEL"),
 *   description = @Translation("TODO."),
 *   name = "PROPERTY_LOWERCAMEL",
 *   group = "MODULE_NAME",
 *   weight = 10,
 *   type = "string",
 *   secure = FALSE,
 *   multiple = FALSE
 * )
 */
class PROPERTY_CLASS_NAME extends SchemaNameBase {

}

CODE
);
    if [ -z "$ARG_MODULE_NAME" ]; then
      read -p "Enter the module machine name (e.g. schema_splash_mountain): " ARG_MODULE_NAME;
    fi;
    if [ -z "$ARG_PROPERTY_UNDERSCORED" ]; then
      read -p "Enter the snake_case property identifier (e.g. slide_count): " ARG_PROPERTY_UNDERSCORED;
    fi;
    if [ -z "$ARG_PROPERTY_LOWERCAMEL" ]; then
      read -p "Enter the lowerCamel property identifier (e.g. slideCount): " ARG_PROPERTY_LOWERCAMEL;
    fi;
    if [ -z "$ARG_PROPERTY_CLASS_NAME" ]; then
      read -p "Enter the property class name (e.g. SchemaSplashMountainSlideCount): " ARG_PROPERTY_CLASS_NAME;
    fi;

    local config=$(sed "
      s/MODULE_NAME/$ARG_MODULE_NAME/g;
      s/PROPERTY_UNDERSCORED/$ARG_PROPERTY_UNDERSCORED/g;
      s/PROPERTY_LOWERCAMEL/$ARG_PROPERTY_LOWERCAMEL/g;" <<< $skeleton_config);

    local code=$(sed "
      s/MODULE_NAME/$ARG_MODULE_NAME/g;
      s/PROPERTY_UNDERSCORED/$ARG_PROPERTY_UNDERSCORED/g;
      s/PROPERTY_LOWERCAMEL/$ARG_PROPERTY_LOWERCAMEL/g;
      s/PROPERTY_CLASS_NAME/$ARG_PROPERTY_CLASS_NAME/g;" <<< $skeleton_code);

    echo "$config" >> "$ARG_MODULE_NAME/config/schema/$ARG_MODULE_NAME.metatag_tag.schema.yml";
    echo "$code" > "$ARG_MODULE_NAME/src/Plugin/metatag/Tag/$ARG_PROPERTY_CLASS_NAME.php";

  }

# Initialize main action.
case $ACTION in
  "generate-module"):
    generate_module; ;;
  "generate-property"):
    generate_property "${@:2}"; ;;
  *):
    echo "No action specified, exiting."; ;;
esac;
