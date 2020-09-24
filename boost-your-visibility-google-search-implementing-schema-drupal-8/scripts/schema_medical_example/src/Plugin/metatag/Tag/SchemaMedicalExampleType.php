<?php

namespace Drupal\schema_medical_example\Plugin\metatag\Tag;

use Drupal\schema_metatag\Plugin\metatag\Tag\SchemaTypeBase;

/**
 * Provides a plugin for the 'type' meta tag.
 *
 * @MetatagTag(
 *   id = "schema_medical_example_type",
 *   label = @Translation("@type"),
 *   description = @Translation("REQUIRED. The type of medical example."),
 *   name = "@type",
 *   group = "schema_medical_example",
 *   weight = -10,
 *   type = "string",
 *   secure = FALSE,
 *   multiple = FALSE
 * )
 */
class SchemaMedicalExampleType extends SchemaTypeBase {

  /**
   * {@inheritdoc}
   */
  public static function labels() {
    return [
      'MedicalExample',
    ];
  }

}
