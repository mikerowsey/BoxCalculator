import SwiftUI

struct ContentView: View {

    @State private var vm = ShipmentViewModel()

    @State private var copied = false

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("Shipping Package Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)

            HStack {

                Text("Qty")
                    .frame(width: 60)

                Text("Length")
                    .frame(width: 80)

                Text("Width")
                    .frame(width: 80)

                Text("Height")
                    .frame(width: 80)

                Text("Weight")
                    .frame(width: 100)

                Text("Totals")
                    .frame(width: 220, alignment: .leading)

                Spacer()
            }
            .font(.headline)

            ForEach($vm.packages) { $package in

                HStack(spacing: 12) {

                    TextField(
                        "Qty",
                        text: $package.quantity
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 60)

                    TextField(
                        "in",
                        text: $package.length
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)

                    TextField(
                        "in",
                        text: $package.width
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)

                    TextField(
                        "in",
                        text: $package.height
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)

                    TextField(
                        "lb",
                        text: $package.weight
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)

                    VStack(alignment: .leading) {

                        Text(
                            String(
                                format: "%.2f kg",
                                vm.lineWeightKG(package)
                            )
                        )

                        Text(
                            String(
                                format: "%.3f CBM",
                                vm.lineCBM(package)
                            )
                        )
                    }
                    .frame(width: 220, alignment: .leading)

                    Button("Remove") {

                        vm.removePackage(
                            id: package.id
                        )
                    }
                }
            }

            HStack {

                Button("Add Package") {
                    vm.addPackage()
                }

                Spacer()
            }

            Divider()

            VStack(alignment: .leading, spacing: 10) {

                Text("Shipment Totals")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(
                    String(
                        format: "Total Boxes: %.0f",
                        vm.totalBoxes
                    )
                )

                Text(
                    String(
                        format: "Total Weight: %.2f lb / %.2f kg",
                        vm.totalWeightLB,
                        vm.totalWeightKG
                    )
                )

                Text(
                    String(
                        format: "Total CBM: %.3f",
                        vm.totalCBM
                    )
                )
            }

            Divider()

            VStack(alignment: .leading, spacing: 12) {

                HStack {

                    Text("Metric Export Table")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Spacer()

                    Button("Copy to Clipboard") {

                        ClipboardService.copy(
                            vm.metricTableText
                        )

                        copied = true

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 2
                        ) {
                            copied = false
                        }
                    }

                    if copied {

                        Text("Copied")
                            .foregroundStyle(.green)
                    }
                }

                ScrollView {

                    Text(vm.metricTableText)
                        .font(
                            .system(
                                size: 15,
                                design: .monospaced
                            )
                        )
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(16)
                        .background(
                            Color.gray.opacity(0.08)
                        )
                        .cornerRadius(10)
                }
                .frame(height: 260)
            }

            Spacer()
        }
        .padding(35)
        .frame(minWidth: 1250, minHeight: 850)
    }
}

#Preview {
    ContentView()
}
