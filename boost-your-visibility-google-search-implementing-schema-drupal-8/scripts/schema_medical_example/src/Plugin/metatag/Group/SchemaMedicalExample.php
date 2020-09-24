<?php

namespace Drupal\schema_medical_example\Plugin\metatag\Group;

use Drupal\schema_medical_entity\Plugin\metatag\Group\SchemaMedicalEntity;

/**
 * Provides a plugin for the 'MedicalExample' meta tag group.
 *
 * @MetatagGroup(
 *   id = "schema_medical_example",
 *   label = @Translation("Schema.org: MedicalExample"),
 *   description = @Translation("See Schema.org definitions for this Schema type at <a href="":url"">:url</a>.", arguments = {
 *     ":url" = "https://schema.org/MedicalExample",
 *   }),
 *   weight = 110,
 * )
 */
class SchemaMedicalExample extends SchemaMedicalEntity {

}
