package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"k8s.io/klog"

	"github.com/vaishutin/t1cloud-k8s-csi/driver"
)

var (
	endpointFlag string
)

func init() {
	flag.Set("logtostderr", "true")
}

func main() {

	cmd := &cobra.Command{
		Use:   os.Args[0],
		Short: "T1Cloud csi driver",
		Run: func(cmd *cobra.Command, args []string) {
			klog.Infof("startDriver")
			startDriver()
		},
	}

	cmd.PersistentFlags().StringVar(&endpointFlag, "endpoint", "", "CSI endpoint")
	cmd.MarkPersistentFlagRequired("endpoint")

	if err := cmd.Execute(); err != nil {
		panic(fmt.Errorf("error in executing command: [%v]", err))
	}

	return

}

func startDriver() {
	drv := driver.CreateDriver(endpointFlag)
	klog.Infof("Create driver on %s", endpointFlag)

	drv.Setup()
}
