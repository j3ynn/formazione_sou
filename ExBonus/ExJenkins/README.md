# Weekday Build Check (Groovy Date Stage)

## Overview

This stage was implemented as part of a Jenkins pipeline training exercise. The goal is to ensure that a build only runs on working days (Monday to Friday), while a warning is produced on weekend days (Saturday and Sunday). The day of the week must be determined using Groovy's native `Date` object, not a shell command (e.g. `date`).

## Requirement

> Write a Jenkins pipeline that runs a build only from Monday to Friday, and prints a warning message on Saturday and Sunday. The day of the week must not be retrieved through a shell command, but through the `Date` object provided by the Groovy language.

## Implementation

A dedicated `Date` stage was added to the pipeline. It uses Groovy's `Date` class together with the `format('E')` pattern to retrieve the abbreviated name of the current day of the week. This value is then compared against the weekend days to decide whether to proceed with the build or print a warning instead.

```groovy
stage('Date') {
    steps {
        script {
            // Get the current day of the week (abbreviated form)
            def GiornoSettimana = new Date().format('E')

            // Debug line to verify the actual value returned
            echo "Valore: ${GiornoSettimana}"

            // If today is Saturday or Sunday, print a warning and skip the build
            if (GiornoSettimana == 'sab' || GiornoSettimana == 'dom') {
                error "weekend niente build"
            } else {
                sh 'echo "giorno lavorativo build eseguibile"'
            }
        }
    }
}
```

## Important Note on Locale

The output of `Date.format('E')` is locale-dependent. On systems configured with an Italian locale, the method returns abbreviated Italian day names (`lun`, `mar`, `mer`, `gio`, `ven`, `sab`, `dom`) instead of the English ones (`Mon`, `Tue`, `Wed`, `Thu`, `Fri`, `Sat`, `Sun`). The comparison values in this stage were chosen to match the Italian abbreviations, since that is the locale of the Jenkins instance used for this exercise.

For a solution that is portable across systems with different locales, a locale-independent approach is preferable, for example using `Calendar.DAY_OF_WEEK` together with the `Calendar.SATURDAY` and `Calendar.SUNDAY` constants, which do not depend on language settings.

## Testing

The stage was tested by running the pipeline and inspecting the Console Output, which prints the value returned by `Date.format('E')` for verification purposes before the conditional check is evaluated.