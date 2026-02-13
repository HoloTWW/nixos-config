import Quickshell
import "bar"

ShellRoot {
    id: root

     LazyLoader{ active: true; component: Bar{} }
}
