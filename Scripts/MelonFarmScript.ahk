#Requires AutoHotkey v2.0
#SingleInstance Force

toggle := false
phaseIndex := 1
nextChange := 0

; Movement sequence: initial A, six WA/WD pairs, then S.
phases := [{keys: ["a"], duration: 50, jitter: false}]

Loop 6 {
    phases.Push({keys: ["w", "a"], duration: 72000, jitter: true})
    phases.Push({keys: ["w", "d"], duration: 72000, jitter: true})
}

phases.Push({keys: ["s"], duration: 3800, jitter: true})

F1::
{
    global toggle, phaseIndex, nextChange

    ; Wait for release so holding F1 doesn't repeatedly toggle.
    KeyWait("F1")

    Critical("On")

    toggle := !toggle
    Send("{F6}")  ; Toggle the autoclicker once.

    if toggle {
        phaseIndex := 1
        nextChange := 0
        SetTimer(AdvanceMovement, 20)
        AdvanceMovement()
    } else {
        SetTimer(AdvanceMovement, 0)
        ReleaseMovement()
    }

    Critical("Off")
}

AdvanceMovement()
{
    global toggle, phases, phaseIndex, nextChange

    Critical("On")

    if !toggle || A_TickCount < nextChange
        return

    ReleaseMovement()

    phase := phases[phaseIndex]

    for key in phase.keys
        Send("{" key " down}")

    offset := phase.jitter ? Random(0, 200) : 0
    nextChange := A_TickCount + phase.duration + offset

    phaseIndex += 1
    if phaseIndex > phases.Length
        phaseIndex := 1

    Critical("Off")
}

ReleaseMovement()
{
    Send("{w up}{a up}{s up}{d up}")
}